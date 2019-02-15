function imobj = mirrorRight2Left(imobj)

%% MIRRORRIGHT2LEFT ... 
%   
%  Usage:  mirrored_image = mirrorRight2Left(image) 
%          ^ NIfTI
%% Version $Revision: 2420 $ was created $Date: 2013-04-22 13:32:32 -0500 (Mon, 22 Apr 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-04-22 13:32:32 -0500 (Mon, 22 Apr 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/mirrorRight2Left.m $ 
%% Developed on Matlab 8.1.0.604 (R2013a) 
%% $Id$ 

imobj = imcast(imobj, 'mlfourd.NIfTI');
tmp = imobj.img;
hx = floor(imobj.size(1)/2);
lenx = imobj.size(1);
for x = 1:hx
    tmp(lenx+1-x,:,:) = imobj.img(x,:,:);
end
imobj.img = tmp;
imobj.fileprefix = [imobj.fileprefix '_mirroredR2L'];






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/mirrorRight2Left.m] ======  
