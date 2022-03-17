%% SAVEFIGURES saves all open figures as *.fig, *.pdf to the filesystem.
%  Usage:  saveFigures([filesystem_location]['closeFigure', true (default) | false]) 
%                       ^ option, pwd by default 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.5.0.197613 (R2015a) 
%% $Id$ 

function saveFigures(varargin)
    ip = inputParser;
    addOptional(ip, 'location', pwd, @ischar);
    addParameter(ip, 'closeFigure', true, @islogical);
    addParameter(ip, 'prefix', '', @ischar)
    parse(ip, varargin{:});
    ipr = ip.Results;

    pwd0 = pwd;
    if (~isfolder(ipr.location)); mkdir(ipr.location); end
    cd(ipr.location);
    theFigs = get(0, 'children');
    N = numel(theFigs);
    assert(N < 1000, 'saveFigures only supports up to 999 open figures');
    for f = 1:N
        aFig = theFigs(f);
        figure(aFig);
        saveas(aFig, sprintf('%s%03d.fig', ipr.prefix, N-f+1));
        saveas(aFig, sprintf('%s%03d.png', ipr.prefix, N-f+1));
        if (ipr.closeFigure); close(aFig); end
    end
    cd(pwd0);
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/saveFigures.m] ======  
