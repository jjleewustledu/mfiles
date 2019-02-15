%PLOTFUNCTION
%
%    Usage:  plotFunction(0, 200, 'j', 'Water CBF', 'Butanol CBF (by
%    Joanne)'
%
%    1st 2 args required
%

function plotFunction(inf, sup, strtgy, xlbl, ylbl)

switch(nargin)
    case 2
        strtgy = 'j'; strategy = ' by Joanne';
        xlbl = 'Water CBF';
        ylbl = ['Butanol CBF' strategy];
    case 3
        if (strcmp('j', strtgy) || strcmp('J', strtgy))
            strategy = ' by Joanne';
        else
            strategy = ' by Tom';
        end
        xlbl = 'Water CBF';
        ylbl = ['Butanol CBF' strategy];
    case 5
    otherwise
        error(help('plotFunction'));
end

NPTS = 100;
inc = (sup - inf)/NPTS;
x = inf:inc:sup; x = x';

table = zeros(NPTS, 2);
acc = inf;
for i = 1:NPTS
    table(i,1) = acc;
    table(i,2) = mexFlowButanol(acc, strtgy);
    acc = acc + inc;
end
plot(table)
xlabel(xlbl);
ylabel(ylbl);

