function cbfNii = simpleCbf(countsNii, a, b, tag)

    %% SIMPLECBF ... 
    %  Usage:  cbf_nifti = simpleCbf(counts_nifti, A_factor, B_factor) 
    %          ^ 
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into svn repository $URL$ 
    %% Developed on Matlab 8.3.0.532 (R2014a) 
    %% $Id$ 

    p = inputParser;
    addRequired(p, 'countsNii', @(x) isa(x, 'mlfourd.NIfTI'));
    addRequired(p, 'a',         @isnumeric);
    addRequired(p, 'b',         @isnumeric);    
    addOptional(p, 'tag', '',   @ischar);
    countsImg = countsNii.img;
    cbfImg    = a * countsImg .* countsImg + b * countsImg;
    
    cbfNii = countsNii;
    cbfNii.fileprefix = [countsNii.fileprefix tag '_cbf'];
    cbfNii.img = cbfImg;

end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/simpleCbf.m] ======  
