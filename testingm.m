	function idx = testingm(imgTag, imgDat)
		
        idx = -1;
		switch class(imgTag)
			case 'double'
				idx = imgTag;
			case 'char'
				for i = 1:size(imgDat.images,2)
					if (strcmp(imgTag, imgDat.images{i}.imageName) | ...
                        strcmp(imgTag, imgDat.images{i}.imageSafeName)) 
						idx = i;
                        break
                    end
				end
			otherwise
				error(['publishPlots_singlepatient_gen.tag2idx:  could not recognize the class of imgTag -> ' class(imgTag)]);
		end
