%BAYESSLICE4
%
%  USAGE:  [aSlice] = bayesSlice4(idx)
%
%          idx is an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aSlice] = bayesSlice4(idx)

slices = [ 5 6 6 6 6 ...
         6 6 6 6 6 ...
         6 6 6 0 6 ...
         6 6 6 6 ];
         
sizes = size(slices);
len   = sizes(2);
if (idx < 1)
    aSlice = slices;          
elseif (idx > len)    
    aSlice = slices(len);
else
    aSlice = slices(idx);
end