function imcmp = savexw(obj)
    %% SAVEXW converts workspace vars into NIfTI and saves them
    %  accepts complex arrays, structs

    TO_IGNORE = {'AUTOSAVE_FILE' 'LOAD_LAST_WORKING_STATE' 'registry' 'registry_path' };
    DESCRIP   =  'mm01_026_p7749_2010dec3';

    iname = inputname(1);
    assert(~isempty(iname));
    if (isstruct(obj))
        imcmp = saveStruct(obj);
    else
        imcmp = saveObject(obj, iname);
    end

    
    
    function strct = saveStruct(strct)
        fnames = fieldnames(strct);
        for s = 1:length(fnames)
            try
                saved = saveObject(strct.(fnames{s}), fnames{s});
                if (isempty(saved))
                    strct = rmfield(strct, fnames{s});
                else
                    strct.(fnames{s}) = saved;
                end
            catch ME
                handwarning(ME);
            end
        end
    end
    function ob    = saveObject(ob, iname)
        if (~any(strcmp(iname, TO_IGNORE)) && ...
             isnumeric(ob)           && ...
             length(size(ob)) >= 3)
            ob = saveNumeric(ob, iname);
        else
            ob = [];
        end
    end
    function imcmp = saveNumeric(img, iname)
        if (~isreal(img))
            imcmp = saveComplex(img, iname);
        else        
            imcmp = saveReal(img, iname);
        end
    end
    function imcps = saveComplex(img, iname)
        re    = saveReal(real(img), [iname '_real']); 
        im    = saveReal(imag(img), [iname '_imag']); 
        imcps = mlfourd.ImagingComposite.createFromCell({re im});
    end
    function imcmp = saveReal(img, iname)
        assert(isnumeric(img));
        imcmp = mlfourd.NIfTI(img, iname, DESCRIP);
        imcmp.save;
    end

end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/savexw.m] ======  
