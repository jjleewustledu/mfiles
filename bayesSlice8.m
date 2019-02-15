%BAYESSLICE8
%
%  USAGE:  [aSlice] = bayesSlice8(idx)
%
%          idx is an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aSlice] = bayesSlice8(idx)

slices = [ 	2 1 2 6 0 ...
         2 3 2 2 3 ...
         3 0 3 4 1 ...
         2 2 2 3 ];
         
sizes = size(slices);
len   = sizes(2);
if (idx < 1)
    aSlice = slices;          
elseif (idx > len)    
    aSlice = slices(len);
else
    aSlice = slices(idx);
end