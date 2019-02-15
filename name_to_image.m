%
%  USAGE:  [img idx] = name_to_image(nam, imgDat)
%
%          nam:		name of image
%          imgDat:	struct containing cell-arrays images, names
%
%          img:		dip_image
%          idx:		int index that references img in imgDat.images
%
%  Created by John Lee on 2008-04-18.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function [img idx] = name_to_image(nam, imgDat)

	switch (nargin)
		case 2
		otherwise
			error(help('name_to_image'));
	end
	
	for i = 1:length(imgDat.names) 
		if (strcmp(nam, imgDat.names{i})) idx = i; end
	end
	img = imgDat.images{idx};