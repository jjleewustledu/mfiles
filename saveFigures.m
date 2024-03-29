%% SAVEFIGURES saves all open figures as *.fig, *.png, *.svg to the filesystem.
%  Usage:  saveFigures([filesystem_location=pwd][, closeFigure=false][, prefix=stackstr(3)], ...
%                      [, first_index=1][, ext='.png']) 
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.5.0.197613 (R2015a) 
%% $Id$ 

function saveFigures(location, opts)
    arguments
        location {mustBeTextScalar} = pwd
        opts.closeFigure logical = false
        opts.prefix {mustBeTextScalar} = stackstr(3, use_dashes=true)
        opts.first_index double = 1
        opts.ext {mustBeTextScalar} = '.png'
    end
    ensuredir(location);
    pwd0 = pushd(location);
    
    theFigs = get(0, 'children');
    N = numel(theFigs);
    assert(N < 1000, 'saveFigures only supports up to 999 open figures');

    if 1 == N
        aFig = theFigs(1);
        figure(aFig);
        saveas(aFig, sprintf('%s%s', opts.prefix, opts.ext));
        saveas(aFig, sprintf('%s.svg', opts.prefix));  
        saveas(aFig, sprintf('%s.fig', opts.prefix));        
        if (opts.closeFigure); close(aFig); end
        return
    end

    for f = opts.first_index:N
        aFig = theFigs(f);
        figure(aFig);
        saveas(aFig, sprintf('%s%03d%s', opts.prefix, N-f+opts.first_index, opts.ext));
        saveas(aFig, sprintf('%s%03d.svg', opts.prefix, N-f+opts.first_index));   
        saveas(aFig, sprintf('%s%03d.fig', opts.prefix, N-f+opts.first_index));        
        if (opts.closeFigure); close(aFig); end
    end

    popd(pwd0);
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/saveFigures.m] ======  
