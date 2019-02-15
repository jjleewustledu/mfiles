%SLICE1
%
%  USAGE:  [aSlice] = slice1(idx)
%
%          idx is an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aSlice] = slice1(idx)

warning('FunctionUsage:Deprecated', 'function slice1 is deprecated');

[pid idx] = ensurePid(idx, 'np287');

slices = [ 6 3 1 0 2 ...
         0 5 4 4 1 ...
         5 2 5 6 3 ...
         4 4 4 5 ];
         
sizes = size(slices);
len   = sizes(2);
if (idx < 1)
    aSlice = slices;          
elseif (idx > len)    
    aSlice = slices(len);
else
    aSlice = slices(idx);
end
