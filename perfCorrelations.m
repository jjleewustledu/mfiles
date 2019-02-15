%PERFCORRELATIONS cf. processCorrelations2.m for script
%
% NB, check mrFilename & petFilename & MAXint!
%
function perfCorrelations(pt, deconvMethod, hemisphere, concMethod, mrperf, ...
    petperf, MAXint)

% ============
% Housekeeping
% ============

VALIDATE_ONLY = 0;

ONE_TIME = 0;
VERBOSE = 0;
CorrVerb = false;
if VERBOSE ONE_TIME = 1; end

if ONE_TIME
    PTstart = 1;
    PTmax = 1;
else
    PTstart = 1;
    PTmax = 7;
end

DIM     = 256;
MONTrow = 2;
MONTcol = 4;
DIMrow  = MONTrow*DIM;
DIMcol  = MONTcol*DIM;

if ONE_TIME
    STARTslice = 2;
    NUMslices = 2;
else
    STARTslice = 1;    
    NUMslices  = MONTrow*MONTcol;
end

if ( strcmp('Cumulant', concMethod) )
    WORK_DIR = 'T:\Kirschstein\cumulants\';
else
    WORK_DIR = 'T:\Kirschstein\standard\';
end

% ===========  
% do business
% ===========

if VALIDATE_ONLY
    
    perfCorrelations_validate(MAXint);
    
else
    
    % ---------------------------------------------------------------------------------------
    disp(' ');    
    %disp(['MAXint -> ' num2str(MAXint)]);
    disp(['pet->' petperf ' mr->' mrperf ' deconv->' ...
            deconvMethod ' hemisphere->' hemisphere ' conc->' concMethod ', ']);
        % ---------------------------------------------------------------------------------------
        
        %%%for pt = PTstart:PTmax
        
        % ---------------------------------------------------------------------------------------
        disp(' ');      
        if VERBOSE
            disp(['   WORK_DIR    -> ' WORK_DIR]);
            disp(['   mrFilename  -> ' WORK_DIR 'pt' num2str(pt) '\mrList_' deconvMethod ...
                    '_' hemisphere '_' concMethod '.dat']);
            disp(['   petFilename -> ' WORK_DIR 'pt' num2str(pt) '\petList_' deconvMethod ...
                    '_' hemisphere '_' concMethod '.dat']);
        end
        mrFilename  = [WORK_DIR 'pt' num2str(pt) '\mrList_' deconvMethod ...
                '_' hemisphere '_' concMethod '.dat'];
        petFilename = [WORK_DIR 'pt' num2str(pt) '\petList_' deconvMethod ...
                '_' hemisphere '_' concMethod '.dat'];
        fprintf('pt->%u, ', pt);
        % ---------------------------------------------------------------------------------------      
        
        % ======
        % Do I/O
        % ======
        
        try
            mrList  = readcollection(mrFilename, 'double', MAXint, 1, 1);
            mrList  = double(squeeze(mrList));
            petList = readcollection(petFilename, 'double', MAXint, 1, 1);
            petList = double(squeeze(petList));
        catch 
            disp(['ERROR:  could not do IO on pt ' num2str(pt) ' deconvMethod ' deconvMethod ...
                    ' concMethod ' concMethod ' hemisphere ' hemisphere ' mrFilename ' mrFilename ' petFilename ' petFilename]);
        end 
        
        try
            % underestimating MAXint so as to avoid off-by-one errors
            disp(['hemisphere->' hemisphere]);
            Correlations2(mrList', petList', MAXint-1, CorrVerb);
        catch
            disp(' ');
            disp(['ERROR:  could not get correlations for pt ' num2str(pt) ' deconvMethod ' deconvMethod ... 
                    ' concMethod ' concMethod ' hemisphere ' hemisphere]);
        end
        
        %%%end % for pt
        
    end % if VALIDATE_ONLY
    
