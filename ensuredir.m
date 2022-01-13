function theDir = ensuredir(varargin)
%% ENSUREDIR
%  @param varargin must be interpretable to fullfile.
%  @param varargin{1:end-1} must be interpretable to mkdir.  
%  @param varargin{end} will also be submitted to mkdir if it is not empty.
%  @returns fullfile(varargin{:}), creating filesystem objects as requested.
%  See also:  isdir, mkdir

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

if strlength(fullfile(varargin{:})) > 0 && ~isfolder(fullfile(varargin{:}))
    try
        if (isempty(varargin{end}))
            varargin1 = {varargin{1:end-1}}; %#ok<CCAT1>
        else
            varargin1 = varargin;
        end
        str = cell2str(varargin1, 'AsRow', true);
        if ~isempty(getenv('DEBUG'))
            fprintf('ensuredir:  attempting call to mkdir(%s)\n', str);
        end
        mkdir(varargin1{:});
    catch ME
        handwarning(ME);
        mlbash(sprintf('mkdir -pv %s', strrep(str, ' ', '/')));
    end
end
theDir = fullfile(varargin{:});

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/ensuredir.m] ======  
