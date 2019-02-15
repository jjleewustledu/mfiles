%FARGPART	FARG test script
%		a SCRIPT with ugly anonymous parentheses
%
%SYNTAX
%--------------------------------------------------------------------------------
%		FARGPART
%
%EXAMPLE
%--------------------------------------------------------------------------------
%		FARGPART

a=pi;b=a;c='c';a=...
	@(x) {...
	x.a,x.(b).c

	patch(a,b,c),foo(a)
	cellfun(@(x) x,b,'uni',false),goo(a)
	};
b=@(x) [
	

x,x
x,x

];
c=...
	@(x) (...
1:x...
);