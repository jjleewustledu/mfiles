% function [] = perf_resconstruct(Filename, FieldStrength, ASLType, FirstimageType,...
%                      SubtractionOrder, SubtractionType, ThreshFlag, threshold, CBFFlag, MeanFlag)
%  
% This MATLAB function is to reconstruct the raw perfusion images from EPI images by the subtraction between labelled images 
% and control images. Quantified CBF images can also be reconstructed by select the option. It is based on SPM99 and 
% MATLAB(5.3 or above) on Redhat Linux 9 or Windows2000.
%    
% The MATLAB code of this function will be found in: http://cfn.upenn.edu/perfusion/software.htm
%    
% All the images are 3D SPM ANALYZE formatted (.img and .hdr). All the results are also saved in SPM ANALYZE format; 
% The labelled and control images should be the data after motion correction.
%    
% The method used here are based on the "simple subtraction", "surround subtraction" and "sinc subtraction" approaches described in
% Aguirre GK et al (2002) Experimental design and the relative sensitivity of perfusion and BOLD fMRI, NeuroImage. 15:488-500. 
%    
% BOLD data (or whatever the underlying pulse sequence that was used) are generated in addition to the perfusion data
%    
% for CASL,
% CBF data are calculated according to the formula from
% Wang J, Alsop DC, et al. (2003) Arterial transit time imaging with flow encoding arterial spin tagging (FEAST).
% Magn Reson Med. 50:599-607. Page600, formula [1]
% CBF_CASL (ml/100g/min) = 60*100*M*¦Ë*R/(2*alp*Mo*(exp(-w*R)-exp(-(t+w)*R))
% where M = raw ASL signal, ¦Ë = blood/tissue water partition coefficient, R =longitudinal relaxation rate of blood,
%       alp = tagging efficiency, Mo =  equilibrium magnetization of brain, 
%       w = post-labeling delay, t = duration of the labeling pulse,  
% and we use the assumed parameters for calculation as ¦Ë=0.9g/ml, 
% for 3T, alp=0.68, T1b=1490ms, R=1/T1b=0.67sec-1. 
% for 1.5T, alp=0.71, T1b=1200ms, R=1/T1b=0.83sec-1.                                                      
%
% for PASL,
% CBF data are calculated according to the formula from
% Wang J, Aguirre GK, et al. (2003) Arterial Spin Labeling Perfusion fMRI With Very Low Task Frequency
% Magn Reson Med. 49:796-802. Page798, formula [1]
% CBF_PASL (ml/100g/min) = 60*100*M*¦Ë/(2*alp*Mo*t*exp(-(t+w)*R))
% where M = raw ASL signal, ¦Ë = blood/tissue water partition coefficient, R =longitudinal relaxation rate of blood,
%       alp = tagging efficiency, Mo =  equilibrium magnetization of brain, 
%       w = post-labeling delay, t = duration of the labeling pulse,  
% and we use the assumed parameters for calculation as ¦Ë=0.9g/ml, 
% for 3T, alp=0.95, T1b=1490ms, R=1/T1b=0.67sec-1. 
% for 1.5T, alp=0.95, T1b=1200ms, R=1/T1b=0.83sec-1.                                                      
%
%  Inputs:
%    Firstimage - integer variable indicating the type of first image 
%    - 0:control; 1:labeled 
%   Select raw images (*.img, images in a order of control1.img, label1.img, control2.img, label2.img,....;
%   or images in a order of label1.img, control1.img, label2.img, control2.img, .... )
%    
%    SubtractionType - integer variable indicating which subtraction method will be used 
%    -0: simple subtraction; 1: surround subtraction;2: sinc subtractioin.
%    for CASL, suppose Perfusion = Control - Label;
%    if the raw images is: (C1, L1, C2, L2, C3...)
%     the simple subtraction is: (C1-L1, C2-L2...)
%     the surround subtraction is: ((C1+C2)/2-L1, (C2+C3)/2-L2,...)
%     the sinc subtraction is: (C3/2-L1, C5/2-L2...)
%    if the raw images is: (L1, C1, L2, C2...)
%     the simple subtraction is: (C1-L1, C2-L2...)
%     the surround subtraction is: (C1-(L1+L2)/2, C2-(L2+L3)/2,...)
%     the sinc subtraction is: (C1-L3/2, C2-L5/2...)
%
%    for PASL, suppose Perfusion = Label - Control;
%    if the raw images is: (C1, L1, C2, L2, C3...)
%     the simple subtraction is: (L1-C1, L2-C2...)
%     the surround subtraction is: (L1-(C1+C2)/2, L2-(C2+C3)/2,...)
%     the sinc subtraction is: (L1-C3/2, L2-C5/2...)
%    if the raw images is: (L1, C1, L2, C2...)
%     the simple subtraction is: (L1-C1, L2-C2...)
%     the surround subtraction is: ((L1+L2)/2-C1, (L2+L3)/2-C2,...)
%     the sinc subtraction is: (L3/2-C1, L5/2-C2...)
%    
%    ThreshFlag - integer variable indicating whether Threshold EPI image series 
%    - 0:no Threshold; 1:Threshold
%    
%    CBFFlag - integer variable indicating whether CBF images are produced 
%    - 0:no CBF images; 1: produced CBF images
%
%    MeanFlag - integer variable indicating whether mean image of all perfusion images are produced 
%    - 0:no mean image; 1: produced mean image
%    
%    
%  Outputs:
%    BOld Images: Bold_*.img,Bold_*.hdr;  Mean_Bold.img, Mean_Bold.hdr; 
%    Perfusion Images: Perf_*.img, Perf_*.hdr; Mean_Perf.img, Mean_Perf.hdr;
%    CBF Images: CBF_*.img, CBF_*.hdr; Mean_CBF.img, Mean_CBF.hdr;
%    
%  By H.Y. Rao & J.J. Wang, @CFN, UPenn Med. 07/2004.


   
function [] = perf_resconstruct(Filename, FieldStrength, ASLType, FirstimageType,...
                      SubtractionOrder, SubtractionType, ThreshFlag, threshold, CBFFlag, MeanFlag)


if nargin<1
    Filename = spm_get(Inf,'*.img','Select imgs to be resconstructed');
end
if isempty(Filename)
    Filename = spm_get(Inf,'*.img','Select imgs to be resconstructed');
end

paranum=2;

if nargin<paranum
 pos=1;
 FieldStrength = spm_input('FieldStrength of scanner, 0:1.5T; 1:3T', pos, 'e', 1,'batch',{},'FieldStrength');
 paranum = paranum + 1;
end;

if nargin<paranum
 pos=pos+1;
 ASLType = spm_input('ASL methods, 0:CASL; 1:PASL', pos, 'e', 0,'batch',{},'ASLType');
 paranum = paranum + 1;
end;

if ASLType == 1;
  if nargin<paranum
    pos=pos+1;
    PASLMo = spm_get(1,'*.img','Select PASL Mo image'); 
    paranum = paranum + 1;
  end;
  if isempty(PASLMo), 
    pos=pos+1;
    PASLMo = spm_get(1,'*.img','Select PASL Mo image');
    paranum = paranum + 1;
  end;
end;
 
if nargin<paranum
 pos=pos+1;
 FirstimageType = spm_input('Firt image type, 0:control; 1:labeled', pos, 'e', 1,'batch',{},'FirstimageType');
 paranum = paranum + 1;
end;

if nargin<paranum
    pos=pos+1;
    SubtractionOrder = spm_input('Please select SubtractionOrder', pos, 'm',...
			'*Even-Odd(Img2-Img1)|Odd-Even(Img1-Img2)',...
			[0 1], 0);
    paranum = paranum + 1;
end;

if nargin<paranum
 pos=pos+1;
 SubtractionType = spm_input('Please selct SubtractionType', pos, 'm',...
			'*simple subtraction|surround subtraction|sinc subtraction',...
			[0 1 2], 0, 'batch',{},'option');
 paranum = paranum + 1;
end;

if SubtractionType==2, 			
 if nargin<paranum
  pos=pos+1;
  Timeshift = spm_input('Time shift of sinc interpolation', pos, 'e', 0.5,'batch',{},'Timeshift');
  paranum = paranum + 1;
 end;
end;

if nargin<paranum
 pos=pos+1;
 CBFFlag = spm_input('Produce quantified CBF images? 0:no; 1:yes', pos, 'e', 1,'batch',{},'CBFFlag');
 paranum = paranum + 1;
end;

if nargin<paranum
 pos=pos+1;
 ThreshFlag = spm_input('Threshold EPI images? 0:no; 1:yes', pos, 'e', 1,'batch',{},'ThreshFlag');
 paranum = paranum + 1;
end;

if ThreshFlag==1,
  pos=pos+1;
  if nargin<paranum
  threshold =  spm_input('Input the Threshold value for EPI', pos, 'e', 200,'batch',{},'threshold');
  paranum = paranum + 1;
end;
end;

if nargin<paranum
 pos=pos+1;
 MeanFlag = spm_input('Produce mean images? 0:no; 1:yes', pos, 'e', 1,'batch',{},'MeanFlag');
 paranum = paranum + 1;
end;

if CBFFlag==1,
  if nargin<paranum
   pos=pos+1;
   Labeltime = spm_input('Enter the label time:sec', pos, 'e', 1.6, 'batch',{},'Labeltime');
   paranum = paranum + 1;
  end;
  if nargin<paranum
   pos=pos+1;
   Delaytime = spm_input('Enter the delay time:sec', pos, 'e', 0.8, 'batch',{},'Delaytime');
   paranum = paranum + 1;
  end;
  if nargin<paranum
   pos=pos+1;
   Slicetime = spm_input('Enter slice acquisition time:msec', pos, 'e', 45, 'batch',{},'Slicetime');
  end;
end;  

if FieldStrength==0, 
  R = 0.83; 
 else 
  R = 0.67;
end;

if ASLType==1,
   alp = 0.95;   %tagging efficiency
end;

if ASLType==0,
   if FieldStrength==0, alp=0.71; end;
   if FieldStrength==1, alp=0.68; end;
end;  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the main program
[Finter,Fgraph,CmdLine] = spm('FnUIsetup','Perf Reconstruct',0);
spm('FigName','Perf Reconstruct: working',Finter,CmdLine);
spm('Pointer','Watch')


% Map images
V=spm_vol(Filename);

if ASLType==1, 
  VMo = spm_vol(PASLMo); 
  PASLModat = zeros([VMo.dim(1:2) 1]);
end;
 
 if SubtractionType>2 
   perfnum=length(V);
 else
   perfnum=fix(length(V)/2);
 end;

 if length(V)==0, error('no raw img files was selected'); end;
 if rem(length(V),2)==1, warning('the number of raw img files is not even, last img is ignored'); end;


% Create output images...
VO = V;
VB = V;
VCBF=V;
VMP = V(1);
VMCBF = V(1);
VMC = V(1);

  for k=1:length(V),
        [pth,nm,xt,vr] = fileparts(deblank(V(k).fname));
        if SubtractionType==0, 
         VO(k).fname = fullfile(pth,['Perf_0' nm xt vr]);
         if CBFFlag==1, VCBF(k).fname = fullfile(pth,['CBF_0_' nm xt vr]);end;
        end;
        if SubtractionType==1, 
         VO(k).fname = fullfile(pth,['Perf_1' nm xt vr]);
         if CBFFlag==1, VCBF(k).fname = fullfile(pth,['CBF_1_' nm xt vr]);end;
        end;
        if SubtractionType==2, 
         VO(k).fname = fullfile(pth,['Perf_2' nm xt vr]);
         if CBFFlag==1, VCBF(k).fname = fullfile(pth,['CBF_2_' nm xt vr]);end;
        end;
        VB(k).fname    = fullfile(pth,['Bold_' nm xt vr]);
  end;

  for k=1:perfnum,
        VO(k)  = spm_create_image(VO(k));
        VB(k)  = spm_create_image(VB(k));
        VCBF(k)  = spm_create_image(VCBF(k));
  end;
  
dat = zeros([VO(1).dim(1:2) length(VO)]);
cdat = zeros([VO(1).dim(1:2) length(VO)]);
ldat = zeros([VO(1).dim(1:2) length(VO)]);
pdat = zeros([VO(1).dim(1:2) perfnum]);
bdat = zeros([VB(1).dim(1:2) perfnum]);

linear_cdat=zeros([VB(1).dim(1:2) 2*perfnum]);
linear_ldat=zeros([VB(1).dim(1:2) 2*perfnum]);
sinc_ldat=zeros([VB(1).dim(1:2) 2*perfnum]);
sinc_cdat=zeros([VB(1).dim(1:2) 2*perfnum]);

%-Start progress plot
%-----------------------------------------------------------------------
spm_progress_bar('Init',V(1).dim(3),'Perf Reconstruct','planes completed');

% The main Loop over planes...
for i=1:V(1).dim(3),
  fprintf('...computing plane.')
  fprintf('%5.1f \n', i)

      % Read a plane for each image...
      M = spm_matrix([0 0 i]);
     if ASLType==1;
       PASLModat(:,:,1)= spm_slice_vol(VMo,M,VMo.dim(1:2),0); 
     end;
      
      for k=1:length(V),
        dat(:,:,k) = spm_slice_vol(V(k),M,V(1).dim(1:2),0);
      end;
      
  % threshold the EPI images 
      Mask=1;
      if ThreshFlag ==1,
        for k=1:length(V),
         Mask = Mask.*(dat(:,:,k)>threshold);
        end;
      end;
 
       for k=1:length(V),
        dat(:,:,k) =dat(:,:,k).*Mask;
        
        if SubtractionOrder==0, 
         if rem(k,2)== 1, ldat(:,:,(k+1)/2) = dat(:,:,k); end;
         if rem(k,2)== 0, cdat(:,:,k/2) = dat(:,:,k); end;
        end;
        if SubtractionOrder==1, 
         if rem(k,2)== 1, cdat(:,:,(k+1)/2) = dat(:,:,k); end;
         if rem(k,2)== 0, ldat(:,:,k/2) = dat(:,:,k); end;
        end;
      end;

       for k=1:perfnum,
           bdat(:,:,k) = (cdat(:,:,k) + ldat(:,:,k))/2;
       end;  

  if SubtractionType==0,
        % do the simple subtraction...
        for k=1:perfnum,
           pdat(:,:,k) = cdat(:,:,k) - ldat(:,:,k);
       end;  
  end;
       
  if SubtractionType==1,
        % do the linear interpolation...
      for x=1:V(1).dim(1),
        for y=1:V(1).dim(2),
           cdata = zeros(1,perfnum);
           ldata = zeros(1,perfnum);
           linear_cdata = zeros(1,length(V));
           linear_ldata = zeros(1,length(V));
           pnum=1:perfnum;
           lnum=1:0.5:perfnum;
           for k=1:perfnum, 
             cdata(k) = cdat(x,y,k);
             ldata(k) = ldat(x,y,k);
           end;
           linear_cdata=interp1(pnum,cdata,lnum);
           linear_ldata=interp1(pnum,ldata,lnum);
           for k=1:2*perfnum-1, 
            linear_cdat(x,y,k)= linear_cdata(k);
            linear_ldat(x,y,k)= linear_ldata(k);
           end;
        end;  
     end;

        % do the surround subtraction....
         if FirstimageType ==1; 
               pdat(:,:,1) = cdat(:,:,1) - ldat(:,:,1);
            for k=2:perfnum, 
               pdat(:,:,k) = linear_cdat(:,:,2*(k-1)) - ldat(:,:,k);
             end;
          end;
         if FirstimageType ==0; 
              pdat(:,:,1) = cdat(:,:,1) - ldat(:,:,1);
            for k=2:perfnum, 
               pdat(:,:,k) = cdat(:,:,k) - linear_ldat(:,:,2*(k-1));
             end;
       end;
  end;


  if SubtractionType==2,
      % do the sinc interpolation...
     for x=1:V(1).dim(1),
        for y=1:V(1).dim(2),
           cdata = zeros(1,perfnum);
           ldata = zeros(1,perfnum);
           sinc_cdata = zeros(1,length(V));
           sinc_ldata = zeros(1,length(V));
           for k=1:perfnum, 
             cdata(k) = cdat(x,y,k);
             ldata(k) = ldat(x,y,k);
           end;
           sincnum = fix(perfnum/Timeshift);
           sinc_cdata=interpft(cdata,sincnum);
           sinc_ldata=interpft(ldata,sincnum);
           for k=1:2*perfnum, 
            sinc_cdat(x,y,k)= sinc_cdata(k);
            sinc_ldat(x,y,k)= sinc_ldata(k);
           end;
        end;  
     end;
 
      % do the sinc subtraction....
         if FirstimageType ==0; 
             for k=1:perfnum, 
               pdat(:,:,k) = sinc_cdat(:,:,2*k) - ldat(:,:,k);
             end;
          end;
         if FirstimageType ==1; 
             for k=1:perfnum, 
               pdat(:,:,k) = cdat(:,:,k) - sinc_ldat(:,:,2*k);
             end;
         end;
  end;      
       

 % Write a plane for each image...
        for k=1:perfnum,
                VO(k) = spm_write_plane(VO(k),pdat(:,:,k),i);
                VB(k) = spm_write_plane(VB(k),bdat(:,:,k),i);
        end;

  if MeanFlag ==1,
    Mean_dat=zeros([VO(1).dim(1:2) 1]);
    VMP.fname = fullfile(pth,['Mean_Perf' xt vr]);
    for k=1:perfnum, Mean_dat(:,:,1) = Mean_dat(:,:,1) + pdat(:,:,k);end;
    Mean_dat(:,:,1) = Mean_dat(:,:,1)/perfnum;
    
    % Write a plane for mean perfusion image...
        VMP(1) = spm_write_plane(VMP(1),Mean_dat(:,:,1),i);
        spm_create_image(VMP(1));
  end;


  if CBFFlag ==1,
     Dtime = Delaytime + Slicetime*i/1000;
     cbfdat = zeros([VO(1).dim(1:2) perfnum]);
     cmean_dat = zeros([VO(1).dim(1:2) 1]);
     for k=1:perfnum, cmean_dat(:,:,1) = cmean_dat(:,:,1) + cdat(:,:,k);end;
     cmean_dat(:,:,1) = cmean_dat(:,:,1)/perfnum;
     VMC.fname = fullfile(pth,['Mean_BOLD' xt vr]);
   
     % Write a plane for mean perfusion image...
        VMC(1) = spm_write_plane(VMC(1),cmean_dat(:,:,1),i);
        spm_create_image(VMC(1));

     for k=1:perfnum, 
       for x=1:V(1).dim(1),
       for y=1:V(1).dim(2),
        if ASLType ==0, 
         if cmean_dat(x,y,1)<threshold, 
          cbfdat(x,y,k)=0;
         else
          cbfdat(x,y,k) = 2700*pdat(x,y,k)*R/alp/((exp(-Dtime*R)-exp(-(Dtime+Labeltime)*R))*cmean_dat(x,y,1));
         end;
        end;
        if ASLType ==1; 
         if cmean_dat(x,y,1)<threshold|PASLModat(x,y,1)<threshold, 
          cbfdat(x,y,k)=0;
         else
          cbfdat(x,y,k) = 2700*pdat(x,y,k)/Labeltime/alp/(exp(-(Dtime+Labeltime)*R)*PASLModat(x,y,1));
         end;
        end;
       end;
       end;
     end;


   % Write a plane for each image...
     for k=1:perfnum,
      VCBF(k) = spm_write_plane(VCBF(k),cbfdat(:,:,k),i);
     end;
  
    Mean_cbfdat=zeros([VO(1).dim(1:2) 1]);
    VMCBF.fname = fullfile(pth,['Mean_CBF' xt vr]);
    for k=1:perfnum, Mean_cbfdat(:,:,1) = Mean_cbfdat(:,:,1) + cbfdat(:,:,k);end;
    Mean_cbfdat(:,:,1) = Mean_cbfdat(:,:,1)/perfnum;
    % Write a plane for mean image...
        VMCBF(1) = spm_write_plane(VMCBF(1),Mean_cbfdat(:,:,1),i);
        spm_create_image(VMCBF(1));
  end;

 spm_progress_bar('Set',i);
end;


if CBFFlag ==1, 
 V1 =spm_vol(VMCBF.fname);
 gcbf = spm_global(V1);
 V2 =spm_vol(VMC.fname);
 gbold = spm_global(V2);
  voxelnum=0;
  zeronum=0;
  globalCBF=0;
  meancontrol=0;
   for i=1:V(1).dim(3),
    clear dat meancbfdat meancondat;
    M = spm_matrix([0 0 i]);
    dat(:,:,1) = spm_slice_vol(V(1),M,V(1).dim(1:2),0);
    meancbfdat(:,:,1) = spm_slice_vol(V1(1),M,V1(1).dim(1:2),0);
    meancondat(:,:,1) = spm_slice_vol(V2(1),M,V2(1).dim(1:2),0);
    for x=1:V(1).dim(1),
      for y=1:V(1).dim(2),
       if meancbfdat(x,y,1) ==0 | meancondat(x,y,1)< threshold,  
       zeronum = zeronum+1;
       else
       voxelnum = voxelnum+1;
       globalCBF = globalCBF+meancbfdat(x,y,1);
       meancontrol = meancontrol+meancondat(x,y,1); 
       end;
      end; 
    end;
  end;
globalCBF = globalCBF/voxelnum;
meancontrol = meancontrol/voxelnum;
end;



  fprintf('\n\t Perfusion images written to: ''%s'' to \n',VO(1).fname)
  fprintf('\t  ''%s''. \n',VO(fix(length(VO)/2)).fname)
  if MeanFlag ==1, 
    fprintf('\t Mean_perf image written to: ''%s''.\n\n',VMP.fname)
  end;  

  fprintf('\t BOLD images written to: ''%s''  to \n',VB(1).fname)
  fprintf('\t ''%s'' . \n',VB(fix(length(VB)/2)).fname)
  fprintf('\t Mean_BOLD image written to: ''%s''.\n\n',VMC.fname)

  if CBFFlag ==1, 
     fprintf('\t Quantified CBF images written to: ''%s'' to \n',VCBF(1).fname)
     fprintf('\t ''%s'' .\n',VCBF(fix(length(VCBF)/2)).fname)
     fprintf('\t Mean Quantified CBF image written to: ''%s'' \n\n',VMCBF.fname)
%    fprintf('\t the calculated voxel number is:')
%    fprintf('\t %8.1f\n',voxelnum)
%    fprintf('\t the zero number is:')
%    fprintf('\t %8.1f\n',zeronum)
     fprintf('\t the global mean BOLD signal is:')
     fprintf('\t %6.2f \n',gbold)
     fprintf('\t the global mean CBF signal is:')
     fprintf('\t %6.3f',globalCBF)
     fprintf('\t ml/100g/min \n\n')
  end;  

 spm_progress_bar('Clear')
  
 fprintf('......computing done.\n\n')

 spm('Pointer');
 spm('FigName','PerfReconstruct done',Finter,CmdLine);




