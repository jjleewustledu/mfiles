function tabulate_mca_rois(matFile)

    import mlfsl.* mlfourd.*;
    
    if (nargin > 0)
        load(matFile);
    else
        
        % Build de novo
        
        
        
    end
    
       
    
    
    
     nocsf_on_hosum = NIfTI.load('nocsf_on_hosum');
     nocsf_on_asl1  = NIfTI.load('nocsf_on_asl1');
     nocsf_on_ep2d  = NIfTI.load('nocsf_on_ep2d');

           pcbf_775 = NIfTI.load('pcbf_rot_blur775');
          asl1a_cbf = NIfTI.load('asl1_cbf');
               scbf = NIfTI.load('cbf_ssvd');
             bipcbf = NIfTI.load('BIP_DerivedCBF_rot');
             bipcbf = bipcbf .* nocsf_on_ep2d;
       
      hosum_modelok = NIfTI.load('asl1a_modelok_on_hosum');
       ep2d_modelok = NIfTI.load('asl1a_modelok_on_ep2d2_rot_mcf_meanvol');
      asl1a_modelok = NIfTI.load('asl1a_modelok');
          asl1a_cbf =  asl1a_cbf          .*  asl1a_modelok; 
    fprintf('asl1a_modelok.dipsum -> %g\n\n', asl1a_modelok.dipsum);    
    fprintf(' ep2d_modelok.dipsum -> %g\n\n',  ep2d_modelok.dipsum);
    fprintf('hosum_modelok.dipsum -> %g\n\n', hosum_modelok.dipsum);
    
    contra_on_hosum = NIfTI.load('mca_contra_on_hosum_rot')                 .* nocsf_on_hosum; 
    contra_on_hosum.fileprefix =     'contra_on_hosum';
    contra_on_asl1  = NIfTI.load('mca_contra_on_asl1_rot')                  .* nocsf_on_asl1;
    contra_on_asl1.fileprefix =      'contra_on_asl1';
    contra_on_ep2d  = NIfTI.load('mca_contra_on_ep2d_rot_mcf_meanvol')      .* nocsf_on_ep2d;
    contra_on_ep2d.fileprefix =      'contra_on_ep2d';

      ipsi_on_hosum = NIfTI.load('mca_ipsi_on_hosum_rot')                   .* nocsf_on_hosum;
      ipsi_on_hosum.fileprefix =     'ipsi_on_hosum';
      ipsi_on_asl1  = NIfTI.load('mca_ipsi_on_asl1_rot')                    .* nocsf_on_asl1;
      ipsi_on_asl1.fileprefix =      'ipsi_on_asl1';
      ipsi_on_ep2d  = NIfTI.load('mca_ipsi_on_ep2d_rot_mcf_meanvol')        .* nocsf_on_ep2d;
      ipsi_on_ep2d.fileprefix =      'ipsi_on_ep2d';

      gray_on_hosum = NIfTI.load('mca_gray_bilat_on_hosum_rot')             .* nocsf_on_hosum;
      gray_on_hosum.fileprefix =     'gray_on_hosum';
      gray_on_asl1  = NIfTI.load('mca_gray_bilat_on_asl1_rot')              .* nocsf_on_asl1;
      gray_on_asl1.fileprefix =      'gray_on_asl1';
      gray_on_ep2d  = NIfTI.load('mca_gray_bilat_on_ep2d_rot_mcf_meanvol')  .* nocsf_on_ep2d;
      gray_on_ep2d.fileprefix =      'gray_on_ep2d';

     white_on_hosum = NIfTI.load('mca_white_bilat_on_hosum_rot')            .* nocsf_on_hosum;
     white_on_hosum.fileprefix =     'white_on_hosum';
     white_on_asl1  = NIfTI.load('mca_white_bilat_on_asl1_rot')             .* nocsf_on_asl1;
     white_on_asl1.fileprefix =      'white_on_asl1';
     white_on_ep2d  = NIfTI.load('mca_white_bilat_on_ep2d_rot_mcf_meanvol') .* nocsf_on_ep2d;
     white_on_ep2d.fileprefix =      'white_on_ep2d';
     
     basal_on_hosum = NIfTI.load('mca_basal_bilat_on_hosum_rot')            .* nocsf_on_hosum;
     basal_on_hosum.fileprefix =     'basal_on_hosum';
     basal_on_asl1  = NIfTI.load('mca_basal_bilat_on_asl1_rot')             .* nocsf_on_asl1;
     basal_on_asl1.fileprefix =      'basal_on_asl1';
     basal_on_ep2d  = NIfTI.load('mca_basal_bilat_on_ep2d_rot_mcf_meanvol') .* nocsf_on_ep2d;
     basal_on_ep2d.fileprefix =      'basal_on_ep2d';
     

     
    modelist = { pcbf_775        asl1a_cbf         scbf             bipcbf };
    masklist = { hosum_modelok   asl1a_modelok     ep2d_modelok     ep2d_modelok };

      ipsi_gray_hosum             =  ipsi_on_hosum   .*  gray_on_hosum;    
      ipsi_gray_hosum.fileprefix  = 'ipsi_gray_on_hosum';
    contra_gray_hosum             =  contra_on_hosum .*  gray_on_hosum;  
    contra_gray_hosum.fileprefix  = 'contra_gray_on_hosum';
      ipsi_gray_asl1              =  ipsi_on_asl1    .*  gray_on_asl1;      
      ipsi_gray_asl1.fileprefix   = 'ipsi_gray_on_asl1';
    contra_gray_asl1              =  contra_on_asl1  .*  gray_on_asl1;    
    contra_gray_asl1.fileprefix   = 'contra_gray_on_asl1';
      ipsi_gray_ep2d              =  ipsi_on_ep2d    .*  gray_on_ep2d;      
      ipsi_gray_ep2d.fileprefix   = 'ipsi_gray_on_ep2d';
    contra_gray_ep2d              =  contra_on_ep2d  .*  gray_on_ep2d;    
    contra_gray_ep2d.fileprefix   = 'contra_gray_on_ep2d';
      ipsi_white_hosum            =  ipsi_on_hosum   .* white_on_hosum;   
      ipsi_white_hosum.fileprefix = 'ipsi_white_on_hosum';
    contra_white_hosum            =  contra_on_hosum .* white_on_hosum; 
    contra_white_hosum.fileprefix = 'contra_white_on_hosum';
      ipsi_white_asl1             =  ipsi_on_asl1    .* white_on_asl1;     
      ipsi_white_asl1.fileprefix  = 'ipsi_white_on_asl1';
    contra_white_asl1             =  contra_on_asl1  .* white_on_asl1;   
    contra_white_asl1.fileprefix  = 'contra_white_on_asl1';
      ipsi_white_ep2d             =  ipsi_on_ep2d    .* white_on_ep2d;     
      ipsi_white_ep2d.fileprefix  = 'ipsi_white_on_ep2d';
    contra_white_ep2d             =  contra_on_ep2d  .* white_on_ep2d;   
    contra_white_ep2d.fileprefix  = 'contra_white_on_ep2d';
    ipsi_basal_hosum              =  ipsi_on_hosum   .* basal_on_hosum;
      ipsi_basal_hosum.fileprefix = 'ipsi_basal_on_hosum';
    contra_basal_hosum            =  contra_on_hosum .* basal_on_hosum; 
    contra_basal_hosum.fileprefix = 'contra_basal_on_hosum';
      ipsi_basal_asl1             =  ipsi_on_asl1    .* basal_on_asl1;     
      ipsi_basal_asl1.fileprefix  = 'ipsi_basal_on_asl1';
    contra_basal_asl1             =  contra_on_asl1  .* basal_on_asl1;   
    contra_basal_asl1.fileprefix  = 'contra_basal_on_asl1';
      ipsi_basal_ep2d             =  ipsi_on_ep2d    .* basal_on_ep2d;     
      ipsi_basal_ep2d.fileprefix  = 'ipsi_basal_on_ep2d';
    contra_basal_ep2d             =  contra_on_ep2d  .* basal_on_ep2d;   
    contra_basal_ep2d.fileprefix  = 'contra_basal_on_ep2d';
    
    roilist  = {{ipsi_on_hosum   contra_on_hosum   gray_on_hosum    white_on_hosum     basal_on_hosum  ...
                 ipsi_gray_hosum contra_gray_hosum ipsi_white_hosum contra_white_hosum ipsi_basal_hosum contra_basal_hosum} ...
                 ...
                {ipsi_on_asl1    contra_on_asl1    gray_on_asl1     white_on_asl1      basal_on_asl1 ...
                 ipsi_gray_asl1  contra_gray_asl1  ipsi_white_asl1  contra_white_asl1} ipsi_basal_asl1  contra_basal_asl1 ...
                 ...
                {ipsi_on_ep2d    contra_on_ep2d    gray_on_ep2d     white_on_ep2d      basal_on_ep2d ...
                 ipsi_gray_ep2d  contra_gray_ep2d  ipsi_white_ep2d  contra_white_ep2d  ipsi_basal_ep2d  contra_basal_ep2d}};
             
    roilist{4} = roilist{3};




    % check [0..1]; truncate ASL ROIs, keeping only model-valid ones; truncate all ROIs to exclude CSF

    for r = 1:length(roilist{1}) %#ok<FORFLG>
        for m = 1:length(modelist)
            roiassert(roilist{m}{r}); 
        end
    end



    % make table's top-most labels

    for m = 1:length(modelist)
        fprintf('%s\t', modelist{m}.label);
    end
    fprintf('\n\n\n');
    
    
    
    % rescale DSC perfusion values
    
      pcbf_white_avg = (contra_white_hosum     .* pcbf_775);
      pcbf_white_avg = pcbf_white_avg.dipsum    / contra_white_hosum.dipsum;
      scbf_white_avg = (contra_white_ep2d      .* scbf);
      scbf_white_avg = scbf_white_avg.dipsum    / contra_white_ep2d.dipsum;
    bipcbf_white_avg = (contra_white_ep2d      .* bipcbf); 
    bipcbf_white_avg = bipcbf_white_avg.dipsum  / contra_white_ep2d.dipsum;
    fprintf('pcbf_white_avg -> %g\n', pcbf_white_avg);

    
    
    % iterate table
    
    lbl = ''; %#ok<NASGU>
    for r = 1:length(roilist{1}) %#ok<FORFLG,*FORPF>
        for m = 1:length(modelist)

            fprintf('%s:\t', roilist{m}{r}.label); 
            lbl = modelist{m}.label;
            if (1 == r)
                switch (m)
                    case 3
                        modelist{3}.img = (pcbf_white_avg/scbf_white_avg)   * modelist{3}.img;
                    case 4
                        modelist{4}.img = (pcbf_white_avg/bipcbf_white_avg) * modelist{4}.img;
                end        
            end
            modelist{m}            = mlfourd.NiiBrowser(modelist{m});
            modelist{m}.fileprefix = lbl;                
            vec = modelist{m}.sampleVoxels(roilist{m}{r} .* masklist{m}); 
            fprintf('%g/%g\t %g\t %g;\t', numel(vec), roilist{m}{r}.dipsum, mean(vec), std(vec)); % modelist{m}.label
        end
        fprintf('\n');
    end % for r



    function roiassert(roi)
        assert(isa(roi, 'mlfourd.INIfTI'));
        assert(roi.dipmax < 1 + eps);
        assert(roi.dipmin >    -eps);
    end % roiassert

end % tabulate_mca_rois
