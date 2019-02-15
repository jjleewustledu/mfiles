function flirtTest(pth, idx)
    %% FLIRTTEST ... 
    %  Usage:  flirtTest(path_to_images, scan_index) 
    %                    ^ to pXXXX_JJL or pXXXX_JJL/fsl 
    %                                    ^ 1, 2, per PET scanning conventions
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into svn repository $URL$ 
    %% Developed on Matlab 8.4.0.150421 (R2014b) 
    %% $Id$ 

    try
        if (~lstrfind(pth, 'fsl'))
            pth = fullfile(pth, 'fsl', ''); end
        cd(pth);
        pnum = str2pnum(pth); 
        assert(~isempty(pnum)); assert(isnumeric(idx));
        idx = num2str(idx);
        flirtbin = '/usr/local/fsl/bin/flirt';
        convertbin = '/usr/local/fsl/bin/convert_xfm';

        in_xas   = 'nu_noneck';
        ref      = [pnum 'tr' idx];
        out_xas  = 'nu_noneck_on_xaxissearch';
        omat_xas = 'nu_noneck_on_xaxissearch.mat';
        flirt_xaxissearch(in_xas, ref, out_xas, omat_xas)
        
        in_fs   = 'nu_noneck_on_xaxissearch';
        ref     = [pnum 'tr' idx];
        out_fs  = ['nu_noneck_on_' ref];
        omat_fs = ['xaxissearch_on_' ref '.mat'];
        flirt_rngsearch(in_fs, ref, out_fs, omat_fs, 20)

        omat = ['nu_noneck_on_' ref '.mat'];
        concat(omat, omat_fs, omat_xas);
        
        in   = 'brain.finalsurfs';
        out  = ['brain_finalsurfs_on_' ref];
        applyxfm(in, ref, out, omat);

    catch ME
        handwarning(ME, 'pth->%s, idx->%s', pth, idx);
    end

    function flirt_xaxissearch(in, ref, out, omat)
        
        in_ng  = [in  '.nii.gz'];
        ref_ng = [ref '.nii.gz'];
        out_ng = [out '.nii.gz'];
        cmd    = sprintf( ...
            '%s -in %s -ref %s -out %s -omat %s -bins 256 -cost corratio -searchrx -90 90 -searchry -0 0 -searchrz -0 0 -dof 6  -refweight %s -interp trilinear', ...
            flirtbin, in_ng, ref_ng, out_ng, omat, ref_ng);
        fprintf([cmd '\n']);
        system(cmd);
    end

    function flirt_rngsearch(in, ref, out, omat, rng)
        
        assert(isnumeric(rng) && rng > 0 && rng <= 90);
        nrng = -1*rng;
        
        in_ng  = [in  '.nii.gz'];
        ref_ng = [ref '.nii.gz'];
        out_ng = [out '.nii.gz'];
        cmd    = sprintf( ...
            '%s -in %s -ref %s -out %s -omat %s -bins 256 -cost corratio -searchrx %i %i -searchry %i %i -searchrz %i %i -dof 6  -refweight %s -interp trilinear', ...
            flirtbin, in_ng, ref_ng, out_ng, omat, nrng, rng, nrng, rng, nrng, rng, ref_ng);
        fprintf([cmd '\n']);
        system(cmd);
    end

    function applyxfm(in, ref, out, init)
        in_ng  =  [in '.nii.gz'];
        ref_ng = [ref '.nii.gz'];
        out_ng = [out '.nii.gz'];
        cmd    = sprintf( ...
            '%s -in %s -ref %s -out %s -applyxfm -init %s -paddingsize 0.0 -interp trilinear', ...
            flirtbin, in_ng, ref_ng, out_ng, init);
        fprintf([cmd '\n']);
        system(cmd);
    end

    function concat(xfm13, xfm23, xfm12)
        cmd = sprintf('%s -omat %s -concat %s %s', convertbin, xfm13, xfm23, xfm12);
        fprintf([cmd '\n']);
        system(cmd);
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/flirtTest.m] ======  
