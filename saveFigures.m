%% SAVEFIGURES saves all open figures as *.fig, *.pdf to the filesystem.
%  Usage:  saveFigures([filesystem_location]['closeFigure', true (default) | false]) 
%                       ^ pwd by default 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.5.0.197613 (R2015a) 
%% $Id$ 

function saveFigures(varargin)
    ip = inputParser;
    addOptional(ip, 'location', pwd, @ischar);
    addParameter(ip, 'closeFigure', true, @islogical);
    parse(ip, varargin{:});

    pwd0 = pwd;
    if (~isfolder(ip.Results.location)); mkdir(ip.Results.location); end
    cd(ip.Results.location);
    theFigs = get(0, 'children');
    N = numel(theFigs);
    assert(N < 1000, 'saveFigures only supports up to 999 open figures');
    for f = 1:N
        aFig = theFigs(f);
        figure(aFig);
        saveas(aFig, sprintf('%03d.fig', N-f+1));
        saveas(aFig, sprintf('%03d.png', N-f+1));
        if (ip.Results.closeFigure); close(aFig); end
    end
    cd(pwd0);
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/saveFigures.m] ======  
