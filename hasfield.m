function [tf, contents] = hasfield(obj, fname)
%% HASFIELD returns true if obj has a field named fname
%  
%  Usage:  if (hasfield(obj, fname)) ...
%                       ^ struct, class
%                            ^ string
%          [~, contents] = hasfield(...); disp(contents)

%% Version $Revision$ was created $Date$ by $Author$ 
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.10.0.499 (R2010a) 
%% $Id$

assert(~isempty(obj));
assert(ischar(fname));
tf = any(strcmp(fname, fieldnames(obj)));
if (tf)
    contents = obj.(fname);
else 
    contents = 0;
end

% Created with NEWFCN.m by Frank Gonzlez-Morphy (frank.gonzalez-morphy@mathworks.de)
% ===== EOF ====== [hasfield.m] ======  
