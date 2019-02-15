%FARGSCPT	FARG test script
%		a SCRIPT with ugly syntax
%
%SYNTAX
%--------------------------------------------------------------------------------
%		FARGSCPT
%
%EXAMPLE
%--------------------------------------------------------------------------------
%		FARGSCPT

	c=cellstr('a'),fh(1)=...					%#ok
		cellfun(@(x) sscanf(x','%s:%d'),c,'uni',...		%#ok
			false);clear c;					%#ok
	y=zeros(2,10);fh(2)={{{@(x,y) x.'*...				%#ok
		y(:,[1,2,5:end])}}};disp(y);