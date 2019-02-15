%
%  USAGE:  img = getPet(pid, metric)
%
%          pid: 	string of form 'vc4354' or the corresponding int index
%          			from pidList
%          metric:	string for metric:  'cbf', 'cbv', 'mtt', 'oef', 'cmro2', 
%                                       'ho1', 'oc1',        'oo1'
%
%          img:		dip_image object 
%
%  Created by John Lee on 2008-04-01.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.
%___________________________________________________________________________________

function img = getPet(pid, metric)

	SUFFIX = '.4dfp.img';
	FWHH   = [10 10 0];
	MMPPIX = [0.9375 0.9375 6.0];
	
	switch (nargin)
		case 2
			[pid p] = ensurePid(pid);
		otherwise
			error(help('getPet'));
	end
	
	sizes = peek4dfpSizes();
	img   = newim(sizes);
	
	switch (metric)
		case 'cbf'
            fname1 = [pathPet(pid) filestemPet(pid, 'cbf') SUFFIX];
            try    				
		        img(:,:,:,0)  = squeeze(read4d(fname1,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0));
		        disp(['getPet:  found ' fname1]);
		    catch
		        error(['getPet:  could not find ' fname1]); 
		    end 
			img = dip_image(...
                    counts_to_petCbf(...
						gaussAnisofFwhh(img, FWHH, MMPPIX), pid));
		case 'cbv'
            fname1 = [pathPet(pid) filestemPet(pid, 'cbv') SUFFIX];
            try    				
		        img(:,:,:,0)  = squeeze(read4d(fname1,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0));
		        disp(['getPet:  found ' fname1]);
		    catch
		        error(['getPet:  could not find ' fname1]); 
		    end 
			img = dip_image(...
                    counts_to_petCbv(...
						gaussAnisofFwhh(img, FWHH, MMPPIX), modelW(pid), modelIntegralCa(pid)));
        case 'mtt'
            cbv = newim(sizes);
            cbf = newim(sizes);
            fname1 = [pathPet(pid) filestemPet(pid, 'cbv') SUFFIX];
            try    				
		        cbv(:,:,:,0)  = squeeze(read4d(fname1,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0));
		        disp(['getPet:  found ' fname1]);
		    catch
		        error(['getPet:  could not find ' fname1]); 
            end
            fname2 = [pathPet(pid) filestemPet(pid, 'cbf') SUFFIX];
            try    				
		        cbf(:,:,:,0)  = squeeze(read4d(fname2,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0));
		        disp(['getPet:  found ' fname1]);
		    catch
		        error(['getPet:  could not find ' fname1]); 
            end
            cbv = dip_image(...
                    counts_to_petCbv(...
						gaussAnisofFwhh(cbv, FWHH, MMPPIX), modelW(pid), modelIntegralCa(pid)));
            cbf = dip_image(...
                    counts_to_petCbf(...
						gaussAnisofFwhh(cbf, FWHH, MMPPIX), pid));
            small = cbf < eps;
            cbf   = (cbf .* ~small) + small;
            img   = 60 * cbv ./ cbf;
            neg   = img < 0;
            peaks = img > (mean(img) + std(img));
            img   = img .* (~neg & ~peaks);
		case 'ho1'
            fname1 = [pathPet(pid) filestemPet(pid, 'ho1') SUFFIX];
		    try    
		        img(:,:,:,0)  = squeeze(read4d(fname1,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0));
		        disp(['getPet:  found ' fname1]);
		    catch
		        error(['getPet:  could not find ' fname1]); 
            end
            img = gaussAnisofFwhh(img, FWHH, MMPPIX);
		case 'oc1'
            fname1 = [pathPet(pid) filestemPet(pid, 'oc1') SUFFIX];
            try    
                img(:,:,:,0)  = squeeze(read4d(fname1,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0));
                disp(['getPet:  found ' fname1]);
            catch
                error(['getPet:  could not find ' fname1]); 
            end
            img = gaussAnisofFwhh(img, FWHH, MMPPIX);
		case 'oo1'
            fname1 = [pathPet(pid) filestemPet(pid, 'oo1') SUFFIX];
            try    
                img(:,:,:,0)  = squeeze(read4d(fname1,'ieee-be','float',sizes(1),sizes(2),sizes(3),1,0,0,0));
                disp(['getPet:  found ' fname1]);
            catch
                error(['getPet:  could not find ' fname1]); 
            end
            img = gaussAnisofFwhh(img, FWHH, MMPPIX);
		otherwise
			error(['getPet:  could not recognize perfusion metric ' metric]);
	end
	
