%FARGTEST	FARG test function
%		a FUNCTION with ugly syntax
%
%SYNTAX
%--------------------------------------------------------------------------------
%		FARGTEST
%
%EXAMPLE
%--------------------------------------------------------------------------------
%		FARGTEST

%--------------------------------------------------------------------------------
% - main function					%#ok
function	[k,varargout	]=	fargtest(...	%#ok
			a, b,	...			%#ok
			varargin...			%#ok
		)					%#ok
		fh1=@(a,  b,   c    )...		%#ok
			a.*b.*c;,,,x=1:10;		%#ok
		x=pi*sind(30);;;,fh2 = {@(x, y)  ...	%#ok
			x  *  y([2 : 3])};x=1:10;	%#ok
		fhx={					%#ok
			@(x) sind(x)			%#ok
			@(z) cosd(z)			%#ok
		};					%#ok
		x=fhx{2}(180*ccc);			%#ok
% - nested functions					%#ok
function	v=...					%#ok
		nest1(...				%#ok
			a)				%#ok
		subfun1;
		fargtest;
end
function	v=nest2(b)				%#ok
		v=cellfun(@(x) any(x),ccc,'uni',false);
		vv=nest1(pi);				%#ok
		fhl(2,3,4);
end
		fhl(1,2,3);
end
% - subroutine						%#ok
function	[ai,bi,varargout]=subfun1...		%#ok
			(ao,bo,varargin)		%#ok
		pi,afun(a,bb)...			%#ok
			={@(x,y) x.*f(y,y([1,5]))},pi	%#ok
		bfun(a([1:4]))=@(x)...			%#ok
			sscanf(x','%s:%d').'.*10;	%#ok
end