%PERFSCATTER returns a scatter plot for all slices of
%            a single patient who has had MR and PET perfusion studies.
%            PERFSCATTER bins pixels into clusters of size BIN_LEN*BIN_LEN.
%
% USAGE:  perfScatter(ptNum, perfParam, deconvMethod, concModel, ...
%                     aifxcoord, aifycoord, aifzcoord, ...
%                     maxMrAxis, maxPetAxis, countLimit, intercept, slope)
%
%         e.g., 
%         perfScatter(3, 'cbf', 'MLEM', 'LOGQUAD', 106, 138, 6 ...
%                     1.0, 150, 64000, 1.0, 1.0), 
%         perfParam    <= 'cbf' or 'cbv' or 'mtt'
%         deconvMethod <= 'MLEM' or 'sSVD' or 'oSVD'
%         concModel    <= 'LOGLIN' or 'LOGQUAD'
%
% $Author$
% $Date$
% $Revision$
% $Source$

function perfScatter(ptNum, perfParam, deconvMethod, concModel, aifxcoord, aifycoord, aifzcoord, ...
                     maxPetAxis, maxMrAxis, countLimit, intercept, slope)

                 
if (countLimit > 600)
    countLimit = 600
end

% ====================================================================
% global variables
% ====================================================================

DEBUG      = 1;
WRITEFILES = 1;
FIT_LINE   = 0;
SHOW_MR    = 1;
SHOW_PET   = 1;
SHOW_MASKS = 1;
SHOW_CNTS  = 1;
SHOW_SCAT  = 1;
COMPUTE_CORR = 0;
ALLOW_PARTIAL_BINS = 0;
     
NROWS   = 256;
NCOLS   = 256;
NSLICES = 32;

ERR_PRCNT = 0.08; % estimate of PET measurement errors from test-retest
BIN_LEN   = 12;    % to match PET voxel sizes, at least
MRFILT    = 6;
PETFILT   = 3;

% -------------------
% screen manipulators
% -------------------

screenSizes   = get(0, 'ScreenSize');  
SCREEN_LEFT   = screenSizes(1);
SCREEN_BOTTOM = screenSizes(2);
SCREEN_WIDTH  = screenSizes(3);
SCREEN_HEIGHT = screenSizes(4);
FIG_LEFT      = 5;
FIG_BOTTOM    = 35;
FIG_HEIGHT    = 0.75*SCREEN_HEIGHT; 
FIG_WIDTH     = FIG_HEIGHT;
GRAPH_ASPECT  = 0.8; % aspect ratio of data-graph size to figure-window size
FONTSIZE      = 18;

% -------
% strings
% -------

PT_STR    = ['pt' num2str(ptNum)];
PET_DIR   = ['T:\Perfusion\pet\' PT_STR '\'];
MASK_DIR  = ['T:\Perfusion\masks\' PT_STR '\'];
STORE_DIR = ['T:\Perfusion\tests\' PT_STR '\'];
DATA_DIR  = ['T:\Perfusion\tests\' PT_STR '\'];

methodFilename  = [DATA_DIR perfParam '_' deconvMethod '_' concModel '_'   ...
                   'aif' num2str(aifxcoord) '-' num2str(aifycoord) '-' num2str(aifzcoord) '.ieee-le.4dfp.img']; 
petFilename     = [PET_DIR 'hersc_on_prebolus3.ieee-le.4dfp.img'];
mrMaskFilename  = [MASK_DIR 'bitten_parenchyma_on_prebolus3.ieee-le.4dbool.img'];
mrListFilename  = [STORE_DIR 'mrList_'  deconvMethod '_' concModel '_' perfParam '.dat'];
petListFilename = [STORE_DIR 'petList_' deconvMethod '_' concModel '_' perfParam '.dat'];
errListFilename = [STORE_DIR 'errList_' deconvMethod '_' concModel '_' perfParam '.dat'];

% ---------
% figure #s
% ---------

if (strcmp('MLEM', deconvMethod)) 
    FigNumBase = 100;
elseif (strcmp('sSVD', deconvMethod)) 
    FigNumBase = 120;
elseif (strcmp('oSVD', deconvMethod)) 
    FigNumBase = 140;
elseif (strcmp('Fourier', deconvMethod)) 
    FigNumBase = 160;
else
    FigNumBase = 80;
end
if (strcmp('Standard', concModel))
    FigNumBase = FigNumBase + 100;
end
mrMaskBase  = 0;
eyeMaskBase = 1;
artMaskBase = 2;
maskBase    = 3;
mrBase      = 4;
mrNaNBase   = 5;
petBase     = 6;
cntsBase    = 7;
checksBase  = 10;

% ====================================================================
% Masks I/O
% ====================================================================

disp(['reading mrMask from ' mrMaskFilename]);
try
    mrMask_dip = nilio_read4d(mrMaskFilename, 'ieee-le', 'uint8', NROWS, NCOLS, NSLICES, 1);
    mrMask_mat = double(mrMask_dip);
catch
    error('   could not read mrMask');
end

% ====================================================================
% MR I/O
% ====================================================================

disp(['reading MR ' perfParam ' map from ' methodFilename]);
try
    mr_mat = gaussAnisof(...
                double(...
                    mrMask_dip*scrubNaNs(...
                        nilio_read4d(methodFilename, 'ieee-le', 'single', NROWS, NCOLS, NSLICES, 1))),... ...
                        	[MRFILT MRFILT MRFILT/2]);
catch
    error('could not read MR hemodynamics map');
end
mr_dip     = dip_image(mr_mat);

% ====================================================================
% PET  I/O
% ====================================================================

disp(['reading PET ' perfParam ' map from ' petFilename]);
try
    pet_mat = gaussAnisof(...
                double(...
                    mrMask_dip*scrubNaNs(...
                        nilio_read4d(petFilename, 'ieee-le', 'single', NROWS, NCOLS, NSLICES, 1))),... ...
                        	[PETFILT PETFILT PETFILT/2]);
catch
    error('could not read PET hemodynamics map');
end
pet_dip     = dip_image(pet_mat);

% ====================================================================
% go over clusters
% ====================================================================

count = 1;
mrMask2_mat = zeros(NROWS, NCOLS, NSLICES, 1);
mrList  = zeros(countLimit,1);
petList = zeros(countLimit,1);
errList = zeros(countLimit,1);  
for slice = 1:NSLICES
    for clustj = 1:floor(NCOLS/BIN_LEN)
        for clusti = 1:floor(NROWS/BIN_LEN)
            
            if (ALLOW_PARTIAL_BINS) % check that at least one clustered pixel in mask is true
                maskBool = false;
                for smallj = 1:BIN_LEN
                    for smalli = 1:BIN_LEN
                        j = (clustj - 1)*BIN_LEN + smallj;
                        i = (clusti - 1)*BIN_LEN + smalli;    
                        maskBool = maskBool | mrMask_mat(i,j,slice,1);
                    end 
                end 
                if (maskBool < 0) error('maskbool < 0'); end
                if (maskBool > 1) error('maskbool > 1'); end
            else % check that all clustered pixels in mask are true
                maskBool = true;
                for smallj = 1:BIN_LEN
                    for smalli = 1:BIN_LEN
                        j = (clustj - 1)*BIN_LEN + smallj;
                        i = (clusti - 1)*BIN_LEN + smalli;    
                        maskBool = maskBool & mrMask_mat(i,j,slice,1);
                    end 
                end 
                if (maskBool < 0) error('maskbool < 0'); end
                if (maskBool > 1) error('maskbool > 1'); end
            end
            
            if (maskBool)                
                % prepare next cluster
                mrAccum = 0;
                petAccum = 0; 
                maskAccum = 0;
                for smallj = 1:BIN_LEN
                    for smalli = 1:BIN_LEN                         
                        j = (clustj - 1)*BIN_LEN + smallj;
                        i = (clusti - 1)*BIN_LEN + smalli;                        
                        mrAccum = mrAccum + mr_mat(i,j,slice,1);
                        petAccum = petAccum + pet_mat(i,j,slice,1);
                        maskAccum = maskAccum + 1;
                        mrMask2_mat(i,j,slice,1) = mrMask2_mat(i,j,slice,1) + 1; 
                    end
                end
                
                % set averages of intra-cluster pixels                
                mrList(count)  = mrAccum/maskAccum;
                petList(count) = petAccum/maskAccum;
                count = count + 1;
                if (count > countLimit) break; end
            end % if maskBool
        end % for clusti
        if (count > countLimit) break; end
    end % for clustj
    if (count > countLimit) break; end
end % for slice

finalCount = count - 1;
disp(['finalCount -> ' num2str(finalCount)]);

% ====================================================================  
% extrema
% ====================================================================  

mrMax  = max(mrList);
mrMin  = min(mrList);
petMax = max(petList);
petMin = min(petList);
disp(['min(mrList)  -> ' num2str(mrMin)]);
disp(['max(mrList)  -> ' num2str(mrMax)]);
disp(['min(petList) -> ' num2str(petMin)]);
disp(['max(petList) -> ' num2str(petMax)]);

% ====================================================================    
% error estimates
% ====================================================================    

for i = 1:countLimit
    errPixels = round( ERR_PRCNT*petList(i)*GRAPH_ASPECT*FIG_HEIGHT/petMax );
    if (errPixels^2 > 1) 
        errList(i) = errPixels^2;
    else
        errList(i) = 1;
    end
end

% ====================================================================  
% Results I/O
% ====================================================================

mrList2 = zeros(finalCount,1);
mrList2 = mrList(1:finalCount);
disp(['size(mrList2) -> ' num2str(size(mrList2))]);
mrList2_dip = dip_image(mrList2);
dipfig(FigNumBase + checksBase + 0, 'mrList2_dip');
mrList2_dip


petList2 = zeros(finalCount,1);
petList2 = petList(1:finalCount);
disp(['size(petList2) -> ' num2str(size(petList2))]);
petList2_dip = dip_image(petList2);
dipfig(FigNumBase + checksBase + 1, 'petList2_dip');
petList2_dip

errList2 = zeros(finalCount,1);
errList2 = errList(1:finalCount);
disp(['size(errList2) -> ' num2str(size(errList2))]);
errList2_dip = dip_image(errList2);
dipfig(FigNumBase + checksBase + 2, 'errList2_dip');
errList2_dip

if WRITEFILES
    writecollection(mrList2,  'single', mrListFilename); 
    writecollection(petList2, 'single', petListFilename);
    disp(['writing mrList2 to:  ' mrListFilename]);
    disp(['writing petList2 to:  ' petListFilename]);
end

% ====================================================================  
% display
% ====================================================================

if SHOW_SCAT
    figure('Position', [FIG_LEFT FIG_BOTTOM FIG_WIDTH FIG_HEIGHT]) 
    scatter(petList2, mrList2, errList2, 'k')
    
    %axis manual
    %axis image
    %axis([-0.1*maxPetAxis maxPetAxis -0.1*maxMrAxis maxMrAxis])
    
    title([deconvMethod ', ' concModel], 'FontSize', 1.5*FONTSIZE)
    if (strcmp('cbf', perfParam))
        petUnits = ' (mL/100g/min)';
    elseif (strcmp('cbv', perfParam))
        petUnits = ' (mL/100g)';
    elseif (strcmp('mtt', perfParam))
        petUnits = ' (sec)';
    else
        petUnits = '';
    end
    xlabel(['PET ' perfParam petUnits],             'FontSize', FONTSIZE)
    ylabel(['MR '  perfParam ' (arbitrary units)'], 'FontSize', FONTSIZE)
    
    if FIT_LINE
            hold on
            x0 = 0:0.01:1;
            y0 = fittedline(intercept, slope, x0);
            plot(x0, y0, '-r', 'LineWidth', 2)
            hold off
    end
    
end

mrMask2_dip = dip_image(mrMask2_mat);
if SHOW_CNTS
    dipfig(FigNumBase + cntsBase, 'mrMask2_dip')
    mrMask2_dip
end

if SHOW_MASKS
    dipfig(FigNumBase + maskBase, 'mrMask_dip')
    mrMask_dip
end

if SHOW_MR 
    dipfig(FigNumBase + mrBase, 'mr_dip')
    mr_dip
end

if SHOW_PET 
    dipfig(FigNumBase + petBase, 'pet_dip')
    pet_dip
end

% ====================================================================  
% Correlations
% ====================================================================  

if (COMPUTE_CORR)
    disp(['Patient#, Hemisphere, Intercept, Slope, s(Intercept), s(Slope),' ...
            ' DoF, c2/DoF, Q, Pearson R, Pearson Pr{R}, Spearman R, Spearman Pr{R}']);
    if (strcmp('cbf', perfParam))
        petParam = 'HOM';
    elseif (strcmp('cbv', perfParam))
        petParam = 'COM';
    elseif (strcmp('mtt', perfParam))
        petParam = 'MTM';
    end
    %%%perfCorrelations(ptNum, deconvMethod, concModel, perfParam, petParam, min(countLimit, finalCount));
end
