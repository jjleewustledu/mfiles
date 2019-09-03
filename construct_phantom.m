function construct_phantom(varargin)
    %% CONSTRUCT_PHANTOM supports niftypet.  It is the top level of a Matlab Compiler Runtime project.
    %  Usage:  construct_phantom(<folders experssion>)
    %          e.g.:  >> construct_phantom('CCIR_00123/ses-E00123/FDG_DT20190815172721.000000-Converted-NAC')    
    %          e.g.:  >> construct_phantom('CCIR_00123/ses-E0012*/FDG_DT*-Converted-*')
    %
    %  @param foldersExpr is char.
    %  @return fullfile(<folders expression>, 'umapSynth.nii.gz') for phantom.
    
    mlraichle.TracerDirector2.constructPhantomStudy(varargin{:})
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/constructResolved.m] ======  
