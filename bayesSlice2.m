%BAYESSLICE2
%
%  USAGE:  [aSlice] = bayesSlice2(idx)
%
%          idx is an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aSlice] = bayesSlice2(idx)

slices = [ 3 2 -1 -1 1 ...
         1 4 3 3 4 ...
         4 1 4 5 2 ...
         3 3 3 4 ];
         
sizes = size(slices);
len   = sizes(2);
if (idx < 1)
    aSlice = slices;          
elseif (idx > len)    
    aSlice = slices(len);
else
    aSlice = slices(idx);
end

