%PIDTOEXCLUDE
%
% 2 - missing ho1
% 7 -
% 12 -
% 17 - 

function truthValue = pidToExclude(pid, measurementType) ...

	if ~isnumeric(pid), pid = pidList(pid); end

	switch (measurementType)
		case { 'F', 'ho1', 'cbfMlem', 'cbfOsvd', 'cbfSsvd' }
			if (2 == pid || 7 == pid || 12 == pid || 17 == pid || 20 == pid) 
				truthValue = true;
			else
				truthValue = false;
			end
		case { 'CBV', 'CBV', 'oc1', 'cbvMlem', 'cbvOsvd', 'cbvSsvd' }
			if (7 == pid || 9 == pid || 11 == pid|| 18 == pid || 20 == pid) 
				truthValue = true;
			else
				truthValue = false;
			end
		default
			truthValue = false;
	end
	
