%
%  USAGE:  img_out = superimpose(img_in1, img_in2, brightness)
%
%          img_in1:		dip_image
%          img_in2:		dip_image
%          brightness:	scalar multiplier for img_in2 for enhancing contrast (optional)
%
%          img_out:		dip_image, img_in2 is superimposed upon img_in1 with brightness adjustments
%						img_out = img_in1 + brightness*img_in2
%
%  Created by John Lee on 2008-04-02.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function img_out = superimpose(img_in1, img_in2, brightness)
	
	switch (nargin)
		case 2
            img_in1 = img_in1/max(img_in1);
            img_in2 = img_in2/max(img_in2);
            brightness = mean(img_in1)/mean(img_in2);
        case 3
            img_in1 = img_in1/max(img_in1);
            img_in2 = img_in2/max(img_in2);
		otherwise
			error(help('superimpose'));
    end
    if (isa(img_in1, 'double'))
        img_in1 = dip_image(img_in1); end
    if (isa(img_in2, 'double'))
        img_in2 = dip_image(img_in2); end
	
	img_out = img_in1 + brightness*img_in2;
	
