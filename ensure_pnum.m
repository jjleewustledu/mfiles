%% ENSURE_PNUM
%  Usage:   pnum = ensure_pnum(ident)
function pnum = ensure_pnum(ident)
	
	if (strncmp('vc', ident, 2))
		try
			pnum = vcnum_to_pnum(ident);
            return
		catch ME
			disp(ME);
			error(['ensure_pnum could not find p-number for identifier -> ' ident]);
		end
	end
	if (~strncmp('p', ident, 1))
		error(['ensure_pnum could not recognize identifier -> ' ident]);
	end
	pnum = ident;
end