function cbf1 = flowButanol(cbf, strat, acc, inf, sup)
    %% FLOWBUTANOL returns Peter Herscovitch's butanol correction for finite water permeability.
    %  Usage:      cbf_butanol = flowButanol(cbf, strategy, accuracy, inf, sup)
    %              ^                         ^ numeric, NIfTI, fileprefix
    %                                             ^ 'j' (default) or 't'
    %                                                       ^         ^    ^ numeric
    %  See also:   butanol_correction src, mexFlowButanol binaries
    %% Version $Revision: 1220 $ was created $Date: 2011-10-05 09:28:38 -0500 (Wed, 05 Oct 2011) $ by $Author: jjlee $
    %% and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/flowButanol.m $
    %% Developed on Matlab 7.11.0.584 (R2010b)
    %% $Id$

    if (~exist('strat', 'var')); strat = 'j';  end % 't' or 'j'
    if (~exist('acc',   'var')); acc   = 0.01; end
    if (~exist('inf',   'var')); inf   = 0;    end; infIn = inf;
    if (~exist('sup',   'var')); sup   = 200;  end; supIn = 159; assert(sup <= 200);
    fprintf('flowButanol:  correction applied only to voxels with values in [%g, %g]\n', infIn, supIn);

    cbf1      = cbf;
    class_ori = class(cbf);
    switch (class_ori)
        case 'char'
            cbf1 = mlfourd.NIfTI.load(cbf);
            cbf1.fileprefix = [cbf '_butanol'];
            cbf  = cbf1.img;
        case mlfourd.NIfTI.NIFTI_SUBCLASS
            cbf1.fileprefix = [cbf.fileprefix '_butanol'];
            cbf = cbf.img;
        case numeric_types
    end

    msk = (cbf > infIn) .* (cbf < supIn);
    cbf = ~msk + cbf .* msk;
    cbf = double(cbf);
    try
        cbf = arrayfun(@(f) mexFlowButanol(inf, sup, acc, f, strat), cbf);
    catch ME
        handerror(ME, 'mfiles:unknownError', 'flowButanol:arrayfun(...)');
    end
    cbf = cbf - (~msk);

    switch (class_ori)
        case 'char'
            cbf1.img = cbf;
            cbf1.save;
            cbf1 = cbf1.fileprefix;
        case mlfourd.NIfTI.NIFTI_SUBCLASS
            cbf1.img = cbf;
        case numeric_types
            cbf1 = cbf;
    end
end % flowButanol

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/linkMexFlowButanol.m] ======  
