function ic2 = vec2imagingContext(vec, varargin)
%% VEC2IMAGINGCONTEXT ... 
%  Usage:  ic2 = vec2imagingContext(vec[, 'filename', a_filename, ...]) 
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.7.0.1261785 (R2019b) Update 3.  Copyright 2020 John Joowon Lee. 

assert(isnumeric(vec))
            
switch(length(vec))
    case 65549        
        GLMmask = mlperceptron.PerceptronRegistry.read_glm_atlas_mask();
        GLMmask(GLMmask ~= 0) = 1;
        img = zeros(size(GLMmask));
        img(GLMmask > 0) = vec;
        img = reshape(img, [48 64 48]);
    case 147456
        img = reshape(vec, [48 64 48]);
    otherwise
        error('mfiles:ValueError', 'vec2imagingContext() does not support length vec -> %g', length(vec))
end
ic2 = mlfourd.ImagingContext2(img, varargin{:});

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/vec2imagingContext.m] ======  
