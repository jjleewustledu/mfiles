function [tf,lastfield] = eqtool(A, B, toexclude)
%% EQTOOL evaluates the equivalence of two objects, recursively examining their public parts
%   
%  Usage:  tf = eqtool(A, B, toexclude) 
%          ^ logical
%                            ^ cell-array of fields of structs/objects to exclude from comparisons
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/eqtool.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

tf        = true;
lastfield = '';
if (isempty(A) && isempty(B))
    return
end
if ((isempty(A) && ~isempty(B)) || (~isempty(A) && isempty(B)))
    tf = false;
    return
end
switch (class(A))
    case 'logical'
        tf = tf & eq(A, B);
    case  numeric_types        
        tf = tf & eq(A, B);
    case 'char'
        tf = tf & strcmp(A, B);
    case 'cell'
        for c = 1:length(A)
            tf = tf & eqtool(A{c}, B{c});
        end
    case 'containers.Map'
        tf = tf & eqtool(A.keys, B.keys) & eqtool(A.values, B.values);
    otherwise % structs, objects
        try
            fields = fieldnames(A);
            if (~exist('toexclude', 'var'))
                for f = 1:length(fields) %#ok<*FORFLG>
                    tf = tf & eqtool(A.(fields{f}), B.(fields{f}));
                    if (~tf)
                        lastfield = fields{f};
                    end
                end
            else                
                for f = 1:length(fields)
                    if (~lstrfind(toexclude, fields{f}))
                        tf = tf & eqtool(A.(fields{f}), B.(fields{f}));
                        if (~tf)
                            lastfield = fields{f};
                        end
                    end
                end
            end
            
        catch ME %#ok<NASGU>
            warning('mfiles:OperatorDoesNotSupportObject', ...
                   'fieldnames does not support class(A)->%s and class(B)->%s', class(A), class(B));
            tf = false;
            return;
        end
end
while (numel(tf) > 1)
    tf = all(tf);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/eqtool.m] ======  

