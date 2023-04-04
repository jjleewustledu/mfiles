function loc = locationType(typ, loc0)
%% LOCATIONTYPE returns location data cast as a requested representative type detailed below.
%  @deprecated
%  @param typ is the requested representation:  'folder', 'path'.
%  @param loc0 is the representation of location data provided by the client.  
%  @returns loc is the location data loc0 cast as the requested representation.
            
assert(istext(loc0));
switch typ
    case {'folder' "folder"}
        loc = mybasename(loc0);
    case {'path' "path"}
        loc = loc0;
    otherwise
        error('mlfourd:ValueError', ...
              'ImagingContext2.locationType.loc0->%s not recognized', loc0);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/locationType.m] ======  
