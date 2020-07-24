function Neurosynth_prep333()
%% NEUROSYNTH_PREP333 converts NIfTI to 4dfp, registers to 333 atlas-space, converts z-scores to correlations,
%  and drops correlations < 0 because negative z-scores are not supported by Neurosynthy.
%  It adds paths from ~jjlee.
%  See also:  ~jjlee/MATLAB-Drive/mldl/src/+mldl/Neurosynth
%             ~jjlee/MATLAB-Drive/mlfourd/src/+mlfourd/ImagingContext2
%
%  Usage:  >> Neurosynth_prep333() % run in pwd containing NIfTI images of *association-tst_z*.nii from Neurosynth.org
%           
%% Version $Revision$ was created 20200709 by jjlee, developed on Matlab 9.8.0.1396136 (R2020a) Update 3.  



    % selectively addpath
    assert(isfolder('~jjlee'))
    if ~contains(path, 'jjlee/matlab')
        addpath('~jjlee/matlab', '-end')
    end    
    PublicMatlabRegistry.instance();

    NS = mldl.Neurosynth();
    NS.prep333()


    

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/Neurosynth_prep333.m] ======  
