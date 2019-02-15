function fqfn = imaging2str(varargin)
    %% IMAGING2STR
    %  @param [imobj[, ...]] are imaging objects relevant for mlfourd.ImagingContext and related classes from package mlfourd.
    %  @return str is always a fully-qualified filename or a string with filenames separated by spaces.
    %  Files need not yet exist.
    %  See also:  mlfourd.ImagingContext

    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into svn repository $URL$ 
    %% Developed on Matlab 9.0.0.307022 (R2016a) Prerelease 
    %% $Id$ 

    if (isempty(varargin))
        fqfn = '';
        return
    end
    
    fqfn = '';
    for v = 1:length(varargin)
        fqfn = [fqfn ' ' oneFqfn(varargin{v})]; %#ok<*AGROW>
    end
    fqfn = strtrim(fqfn);
    if (isempty(fqfn))
        fqfn = fullfile(pwd, sprintf('imaging2str_%s.nii.gz', datestr(now, 30))); 
    end
    
    function f = oneFqfn(oneArg)
        switch (class(oneArg))
            case 'cell'
                f = '';
                for o = 1:length(oneArg)
                    f = [f ' ' imaging2str(oneArg{o})];
                end
            case 'char'
                f = oneArg;
            otherwise
                if     (isa(oneArg, 'mlpatterns.Composite'))
                    iter = oneArg.createIterator;
                    f = '';
                    while (iter.hasNext)
                        f = [f ' ' imaging2str(iter.next)];
                    end
                elseif (isa(oneArg, 'mlpatterns.List'))
                    f = '';
                    for o = 1:length(oneArg)
                        f = [f ' ' imaging2str(oneArg.get(o))];
                    end
                elseif (isa(oneArg, 'mlfourd.ImagingContext'))
                    f = imaging2str(oneArg.fqfilename);
                elseif (isa(oneArg, 'mlfourd.INIfTI'))
                    f = imaging2str(oneArg.fqfilename);
                elseif (isnumeric(oneArg))
                    f = '';
                else
                    error('mfiles:unsupportedSwitchcase', 'class(imaging2str.oneFqfn.oneArg)->%s', class(oneArg));
                end
        end
    end    
    
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/imaging2str.m] ======  
