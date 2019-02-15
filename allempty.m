function tf = allempty(obj)
%% ALLEMPTY ... 
%   
%  Usage:  tf = allempty(object) 
%                        ^ cell, struct, class, string, number
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/allempty.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

switch (class(obj))
    case [numeric_types 'char']
        tf = isempty(obj);
    case 'cell'
        tf    = true;
        for o = 1:length(obj)
            tf = tf & allempty(obj{o});
        end
    case 'struct'
        tf   = true;
        if (length(obj) > 1)
            for o = 1:length(obj)
                tf = tf & allempty(obj(o));
            end
        else
            if (isempty(obj)); tf = true; return; end
            flds = fieldnames(obj);
            for f = 1:length(flds)
                tf = tf & allempty(obj.(flds{f}));
            end
        end
    otherwise
        try
            tf    = true;
            props = properties(obj);
            for p = 1:length(props)
                tf = tf & allempty(obj.(props{p}));
            end
        catch ME
            handwarning(ME);
            tf = isempty(obj);
        end
end








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/allempty.m] ======  
