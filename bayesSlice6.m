%BAYESSLICE5
%
%  USAGE:  [aSlice] = bayesSlice5(idx)
%
%          idx is an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aSlice] = bayesSlice5(idx)

slices = [ 0 4 5 4 6 ...
         5 1 0 0 1 ...
         1 6 1 2 4 ...
         0 0 0 1 ];
         
sizes = size(slices);
len   = sizes(2);
if (idx < 1)
    aSlice = slices;          
elseif (idx > len)    
    aSlice = slices(len);
else
    aSlice = slices(idx);
end