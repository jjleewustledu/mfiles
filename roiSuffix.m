
%
% USAGE:	suff = roiSuffix(pid)
%
%           pid:   int or string
%			suff:  string
%

function suff = roiSuffix(pid)
    
    SUFFIXES = {'_Xr3d' '_Xr3d' '_Xr3d' '_on_perfusionVenous_xr3d' 't' ...
                '_Xr3d' '_Xr3d' '_xr3d' '_Xr3d' '_Xr3d' ...
                '_Xr3d' '_Xr3d' '_Xr3d' '_Xr3d' '_Xr3d' ...
                '_Xr3d' '_Xr3d' '_Xr3d' '_Xr3d'};

    [pid p] = ensurePid(pid);       

	if (p <= length(SUFFIXES))
    	suff = SUFFIXES{p}; 
	else
		suff = '';
	end
end
