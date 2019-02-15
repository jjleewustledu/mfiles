%OCHDRLIST
%
%  USAGE:  [fully qualified filename] = ocHdrList(idx)
%
%          idx is an integer index
%          idx < 1 returns the complete list
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aFile] = ocHdrList(idx)

path = '/data/mozart/data3/np287/';

pnum = { 'p5696' 'empty' 'p5740' 'p5743' 'p5760' ...
         'p5761' 'p5771' 'p5772' 'p5774' 'p5777' ...
         'p5780' 'empty' 'p5784' 'p5792' 'p5807' ...
         'p5842' 'p5846' 'p5850' 'p5856' };
     
hdrSuffix = { 'oc1_g3' 'empty'  'oc1_g3' 'empty' 'oc1_g3' ...
              'oc1_g3' 'oc1_g3' 'oc1_g3' 'oc1_g3' 'oc1_g3' ...
              'oc1_g3' 'empty'  'oc1_g3' 'oc1_g3' 'oc1_g3' ...
              'oc1_g3' 'oc1_g3' 'oc1_g3' 'oc1_g3' };  
         
sizes = size(pnum);
len   = sizes(2);
if (idx < 1)
    aFile = pnum;          
elseif (idx > len)    
    aFile = [path char(pnum(len)) '/' char(pnum(len)) char(hdrSuffix(len)) '.hdr'];
else
    aFile = [path char(pnum(idx)) '/' char(pnum(idx)) char(hdrSuffix(idx)) '.hdr'];
end
aFile = char(aFile);

