function mff = ensureMatchedFileFormat(obj, format0)
%% ENSUREMATCHEDFORMAT returns a filename with filename-format matching a specified template
%  Usage:  filename = ensureMatchedQualified(object, filename_template) 
%                                            ^ object containing filename, e.g., NIfTIInterface
%                                                    ^ format to match
%% Version $Revision: 2615 $ was created $Date: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2013-09-07 19:16:20 -0500 (Sat, 07 Sep 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mfiles/trunk/ensureMatchedFileFormat.m $ 
%% Developed on Matlab 8.0.0.783 (R2012b) 
%% $Id$ 


if (isempty(obj)); mff = ''; return; end
mff = matchup(breakdown(obj), breakdown(format0));

    function bd = breakdown(obj1)
        %% BREAKDOWN returns a struct with fields:  path, fileprefix, ext
        
        switch (class(obj1))
            case 'char'
                bd = struct('fhandle', @breakdown);
                [bd.path,bd.fileprefix,bd.ext] = filepartsx(obj1, mlfourd.NIfTId.FILETYPE_EXT);
            case {'mlfourd.NIfTI' 'mlfourd.ImagingComponent' 'mlfourd.ImagingSeries' 'mlfourd.ImagingComposite'}
                bd = breakdown(obj1.fqfilename);
            case 'cell'
                bd = breakdown(obj1{1});
            case 'mlfourd.ImagingArrayList'
                bd = breakdown(obj1.get(1));
            otherwise
                error('mfiles:UnsupportedType', 'ensureMatchedFileFormat.breakdown.class(object)->%s', class(obj1));
        end
        bd.typeclass = class(obj1);
    end

    function mu = matchup(bd1, fmt1)
        
        assert(isstruct(bd1));
        assert(strcmp(func2str(bd1.fhandle), 'ensureMatchedFileFormat/breakdown'));
        assert(isstruct(fmt1));
        assert(strcmp(func2str(fmt1.fhandle), 'ensureMatchedFileFormat/breakdown'));
        fmt1Fields = fieldnames(fmt1);
        for f = 1:length(fmt1Fields)
            if (isempty(bd1.(fmt1Fields{f})))
                bd1.(fmt1Fields{f}) = fmt1.(fmt1Fields{f}); end
        end
        
        import mlfourd.*;
        bd1Fqfn = fullfile(bd1.path, [bd1.fileprefix bd1.ext]);
        switch (fmt1.typeclass)
            case 'char'
                mu = fmt1; 
                mu.fhandle = @matchup;
                for f = 1:length(fmt1Fields)
                    if (~isempty(fmt1.(fmt1Fields{f})))
                        mu.(fmt1Fields{f}) = bd1.(fmt1Fields{f}); end
                end
                mu = fullfile(mu.path, [mu.fileprefix mu.ext]);
            case 'mlfourd.NIfTI' 
                mu = NIfTI.load(bd1Fqfn);
            case {'mlfourd.ImagingComponent' 'mlfourd.ImagingSeries' 'mlfourd.ImagingComposite'}
                mu = ImagingComponent.load(bd1Fqfn);
            case 'cell'
                fmt1.typeclass = 'char';
                mu = {matchup(bd1, fmt1)};
            case 'mlfourd.ImagingArrayList'
                fmt1.typeclass = 'char';
                mu = mlfourd.ImagingArrayList;
                mu.add(matchup(bd1, fmt1));
            otherwise
                error('mfiles:UnsupportedType', 'ensureMatchedFileFormat.matchup.class(object)->%s', class(fmt1));
        end 
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureMatchedQualified.m] ======  
