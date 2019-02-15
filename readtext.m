function contents = readtext(fname)
%% READTEXT ... 
%   
%  Usage:  contents = readtext(filename) 
%          ^ cell-arr of strings, one per line of text
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/readtext.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 

contents = cell(1,1);
try
    fid = fopen(fname);
    i   = 1;
    while 1
        tline = fgetl(fid);
        if ~ischar(tline),   break,   end
        contents{i} = tline;
        i = i + 1;
    end
    fclose(fid);
catch ME
    disp(ME);
    warning('mfiles:IOErr', ['mfiles.readtext:  could not process file ' fname ' with fid ' num2str(fid)]);
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/readtext.m] ======  
