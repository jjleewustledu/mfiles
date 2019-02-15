% 	ISMEMBER returns bool for whether target is an element of the array or cell array anarray	
% 		[TRUTHVAL] = ISMEMBER(TARGET, ANARRAY)
% 
% 	truthval is a single bool
% 	
% 	Created by John Lee on 2008-12-23.
% 	Copyright (c)  Washington University School of Medicine. All rights reserved.

function truthval = iselement(target, anarray)
	
	if (nargin ~= 2); error(help('ismember')); end
	
	truthval = false;
	switch (class(anarray))
	case 'cell'
		switch (class(target))
		case 'double'
			for i = 1:length(anarray)
				if (target == anarray{i}); truthval = true; return; end
			end
		case 'char'
			for i = 1:length(anarray)
				if (strcmp(target,anarray{i})); truthval = true; return; end
			end
		otherwise
			error(['ismember does not yet recognize targets of class ' class(anarray)]);
		end
	case 'double'
		switch (class(target))
		case 'double'
			for i = 1:length(anarray)
				if (target == anarray(i)); truthval = true; return; end
			end
		case 'char'
			for i = 1:length(anarray)
				if (strcmp(target,anarray(i))); truthval = true; return; end
			end
		otherwise
			error(['ismember does not yet recognize targets of class ' class(anarray)]);
		end
	otherwise
		error(['ismember does not yet support array class ' class(anarray)]);
	end
	
end %  function