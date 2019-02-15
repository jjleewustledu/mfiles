function trydelete(varargin)

try
    delete(varargin{:});
catch ME
    dispwarning(ME);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/trydelete.m] ======  
