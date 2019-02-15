function newName = strrep_on_(oldName)
%% STRREP_ON_ avoids 4dfp behaviors with files named A_on_B.  
%  It replaces all occurences of '_on_' with 'On', also setting the following char to uppercase.
%  Usage:  newName = strrep_on_(oldName) 
%  e.g.:   >> strrep_on_('/pathtofile/this_on_that.4dfp.ifh')
%          ans = 
%               /pathtofile/thisOnThat.4dfp.ifh

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

[pth,fp,x] = myfileparts(oldName);
ks = strfind(fp, '_on_');
for iks = 1:length(ks)
    try
        fp(ks(iks)+4) = upper(fp(ks(iks)+4));
    catch ME
        handwarning(ME);
    end
end
newName = fullfile(pth, [strrep(fp, '_on_', 'On') x]);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/strrep_on_.m] ======  
