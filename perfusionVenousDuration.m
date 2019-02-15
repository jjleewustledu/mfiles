%PERFUSIONVENOUSDURATION
%
%  USAGE:  [aDuration] = perfusionVenousDuration(idx)
%
%          idx is an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aDuration] = perfusionVenousDuration(idx)

if (~isnumeric(idx))
    error(['slice1(idx) was passed non-real-numeric idx -> ' idx]);
end

durations = [ 50 59 71 80 80 ...
         80 80 80 80 55 ...
         5 2 5 6 3 ...
         4 4 4 5 80 ];
         
sizes = size(durations);
len   = sizes(2);
if (idx < 1)
    aDuration = durations;          
elseif (idx > len)    
    aDuration = durations(len);
else
    aDuration = durations(idx);
end
