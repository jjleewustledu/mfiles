%LOCALDIPMENUS   Not a user function
%   LOCALDIPMENUS is used by DIPIMAGE to determine the location of the toolbox
%   functions in the menu system. This function should be edited to give
%   your own functions a fixed place in the DIPimage menu system.
%
%   $Author: jjlee $
%   $Date: 2004/06/15 00:10:06 $
%   $Revision: 1.1 $
%   $Source: /cygdrive/c/local/src/mfiles/RCS/localdipmenus.m,v $

function [menulist,excludelist] = localdipmenus(menulist)

     I = size(menulist,1)+1;
     menulist{I,1} = 'NIL Functions';
     menulist{I,2} = {...
         'readmrseries','readcollection','writecollection','read4d','write4d',...
         'nil_singledicom','nil_writedicom','nil_montagedicom','nil_writemontagedicom',...
         'nil_slice3D','readAscii','readICA'...
     };
     excludelist = {...
         'DICOMViewer','binPixels'...
     };

