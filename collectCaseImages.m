
%
% USAGE:    images = collectCaseImages(pid, imgfrmt, qCBV)
%
%           imgfrmt: 'double', otherwise 'dip_image' will be assumed
%           qCBV:    struct or fully-qualified filename
%           images:  struct with MR and PET images
%

function images = collectCaseImages(pid, imgfrmt, qCBV)

    switch (nargin)
        case 1
            imgfrmt = 'dip_image';
            qCBV = false;
        case 2
            qCBV = false;
        case 3
            if (isa(qCBV, 'char'))
                fqfn = qCBV;
                try
                    qCBV = load(fqfn);
                catch ME9
                    disp(ME9.message);
                    qCBV = false;
                end
            end
        otherwise
            error(help('collectCaseImages'));
    end
    
    NFRAMES = 30;
    quantitative = true;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% COLLECT QCBV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if (isa(qCBV, 'struct'))
        if (strcmp('double', imgfrmt))
            images.qCBV.ROIs         = qCBV.ROIs;
            images.qCBV.cutoffs_ROIs = qCBV.cutoffs_ROIs;
            images.qCBV.image_names  = qCBV.image_names;
            images.qCBV.images       = qCBV.images;
            images.qCBV.masks_ROIs   = qCBV.masks_ROIs;
        else
            images.qCBV.ROIs         = dip_image(qCBV.ROIs);
            images.qCBV.cutoffs_ROIs = dip_image(qCBV.cutoffs_ROIs);
            images.qCBV.image_names  = dip_image(qCBV.image_names);
            images.qCBV.images       = dip_image(qCBV.images);
            images.qCBV.masks_ROIs   = dip_image(qCBV.masks_ROIs);
        end
    end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% COLLECT 4DFP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    cd(['/mnt/hgfs/np797/' pidFolder(pid) '/4dfp'])
    
    images.ep2d_perf_xr3d = read4d(...
        'ep2d_perf_xr3d.4dfp.img', 'ieee-be', 'float', 128,128,13,NFRAMES,0,0,0);
    try
        images.t1_mpr = read4d(...
            't1_mpr_xr3d.4dfp.img', 'ieee-be', 'float', 128,128,13,1,0,0,0);
        %images.t1_mpr = read4d(...
        %    't1_mpr_on_ep2d_perf_r3d.4dfp.img', 'ieee-be', 'float', 128,128,13,1,0,0,0);
    catch ME4
        try
            images.t1_mpr = read4d(...
                'mprage_xr3d.4dfp.img', 'ieee-be', 'float', 128,128,13,1,0,0,0);
        catch ME5
            disp(ME4.message);
            disp(ME5.message);
        end
    end
    try
        images.t2_space = read4d(...
            't2_space_xr3d.4dfp.img', 'ieee-be', 'float', 128,128,13,1,0,0,0);
    catch ME
        try
            images.t2_tse = read4d(...
                't2_tse_xr3d.4dfp.img', 'ieee-be', 'float', 128,128,13,1,0,0,0);
        catch ME2
            disp(ME.message);
            disp(ME2.message);
        end
    end
%     try
%         images.space_ir = read4d(...
%             'space_ir_xr3d.4dfp.img', 'ieee-be', 'float', 128,128,13,1,0,0,0);
%     catch ME3
%         disp(ME3.message);
%     end
    
    cd(['/mnt/hgfs/np797/' pidFolder(pid) '/962_4dfp'])
    
    images.ho1 = read4d(...
        [pid 'ho1_xr3d.4dfp.img'], 'ieee-be', 'float', 128,128,13,1,0,0,0);
    images.oc1 = read4d(...
        [pid 'oc1_xr3d.4dfp.img'], 'ieee-be', 'float', 128,128,13,1,0,0,0);
    images.oo1 = read4d(...
        [pid 'oo1_xr3d.4dfp.img'], 'ieee-be', 'float', 128,128,13,1,0,0,0);
    
    try
        images.petcbf_10mm = counts_to_petCbf(...
            gaussAnisofFwhh(images.ho1, db('petblur'), db('mmppix')), pid);
    catch ME4
        quantitative = false;
        disp(ME4.message);
        disp([pid ' did not have quantitative information in ho1 hdr files']);
    end
    try
        images.petcbv_10mm = counts_to_petCbv(...
            gaussAnisofFwhh(images.oc1, db('petblur'), db('mmppix')), pid);
    catch ME5
        quantitative = false;
        disp(ME5.message);
        disp([pid ' did not have quantitative information in oc1 hdr files']);
    end
    try
        images.oef_10mm = counts_to_petOEF(...
            gaussAnisofFwhh(images.oo1, db('petblur'), db('mmppix')), pid, images.petcbf_10mm, images.petcbv_10mm);
    catch ME6
        quantitative = false;
        disp(ME6.message);
        disp([pid ' did not have quantitative information in oef hdr files']);
    end
    try
        images.cmro2_10mm = counts_to_petCMRO2(...
            images.oef_10mm, images.petcbf_10mm, pid);
    catch ME7
        quantitative = false;
        disp(ME7.message);
        disp([pid ' did not have quantitative information in cmro2 hdr files']);
    end
    try
        images.petcbf_10mm = counts_to_petCbf(...
            gaussAnisofFwhh(images.ho1, db('petblur'), db('mmppix')), pid);
        images.petcbv_10mm = counts_to_petCbv(...
            gaussAnisofFwhh(images.oc1, db('petblur'), db('mmppix')), pid);
        images.oef_10mm = counts_to_petOEF(...
            gaussAnisofFwhh(images.oo1, db('petblur'), db('mmppix')), pid, images.petcbf_10mm, images.petcbv_10mm);
        images.cmro2_10mm = counts_to_petCMRO2(...
            images.oef_10mm, images.petcbf_10mm, pid);
    catch ME8
        quantitative = false;
        disp(ME8.message);
        disp([pid ' did not have quantitative information in ho1 hdr files']);
    end
    
    if (strcmp('double', imgfrmt))
        images.ep2d_perf_xr3d = double(images.ep2d_perf_xr3d);
        images.t1_mpr            = double(images.t1_mpr);
        try
            images.t2_space      = double(images.t2_space);
        catch ME
            try
                images.t2_tse    = double(images.t2_tse);
            catch ME2
                disp(ME.message);
                disp(ME2.message);
            end
        end
        try
            images.space_ir      = double(images.space_ir);
        catch ME3
            disp(ME3.message);
        end
        images.ho1               = double(images.ho1);
        images.oc1               = double(images.oc1);
        images.oo1               = double(images.oo1);
        if (quantitative)
            images.petcbf_10mm   = double(images.petcbf_10mm);
            images.petcbv_10mm   = double(images.petcbv_10mm);
            images.oef_10mm      = double(images.oef_10mm);
            images.cmro2_10mm    = double(images.cmro2_10mm);   
        end
    end