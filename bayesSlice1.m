%BAYESSLICE1
%
%  USAGE:  [aSlice] = bayesSlice1(idx)
%
%          idx is an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aSlice] = bayesSlice1(idx)

if (~isnumeric(idx))
    error(['slice1(idx) was passed non-real-numeric idx -> ' idx]);
end

slices = [ 6 3 1 0 2 ...
         0 5 4 4 5 ...
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
