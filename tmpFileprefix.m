function fqfp = tmpFileprefix(varargin)
    %% TMPFILEPREFIX ... 
    %  Usage:  fq_filenprfix = tmpFileprefix(['func', func_value, 'tag', tag_value, 'path', path_value]) 
    %  @param method is the name of the calling function
    %  @param tag is any string identifier
    %  @param path is the path to the log file
    %  @returns fqfp is a standardized log filename

    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into svn repository $URL$ 
    %% Developed on Matlab 9.0.0.341360 (R2016a) 
    %% $Id$ 

    ip = inputParser;
    addParameter(ip, 'func', 'unknownMethod', @ischar);
    addParameter(ip, 'tag', '', @ischar);
    addParameter(ip, 'path', pwd, @isdir);
    parse(ip, varargin{:});
    tag = ip.Results.tag;            
    if (~isempty(tag) && ~strcmp(tag(end), '_'))
        tag = [tag '_'];
    end

    fqfp = fullfile(ip.Results.path, ...
         sprintf('%s%s_%s', tag, ip.Results.func, mydatetimestr(now)));
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/tmpFileprefix.m] ======  
