function alphanumFolder_to_numFolder()
%% ALPHANUMFOLDER_TO_NUMFOLDER moves all folders named 1234_filename to 1234.  It operates only in the pwd.
%  Usage:  alphanumFolder_to_numFolder() 

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

dt = mlsystem.DirTool('*');
for idx = 1:length(dt.dns)
    re = regexp(dt.dns{idx}, '(?<seriesNum>^[0-9]+)_\S+', 'names');
    try
        mlbash(sprintf('mv "%s" %s', dt.dns{idx}, re.seriesNum));
    catch ME
        handwarning(ME);
    end
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/alphanumFolder_to_numFolder.m] ======  
