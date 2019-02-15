%BAYESSLICE7
%
%  USAGE:  [aSlice] = bayesSlice7(idx)
%
%          idx is an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aSlice] = bayesSlice7(idx)

slices = [ 	1 0 6 5 3 ...
         6 2 1 1 2 ...
         2 3 2 3 0 ...
         1 1 1 2 ];
         
sizes = size(slices);
len   = sizes(2);
if (idx < 1)
    aSlice = slices;          
elseif (idx > len)    
    aSlice = slices(len);
else
    aSlice = slices(idx);
end