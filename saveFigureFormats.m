%% SAVEFIGUREFORMATS saves the foreground figure as *.fig, *.pdf *.eps to the filesystem.
%  Usage:  saveFigureFormats([filesystem_location]) 
%                             ^ pwd by default 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.5.0.197613 (R2015a) 
%% $Id$ 

function saveFigureFormats(varargin)
    ip = inputParser;
    addOptional(ip, 'fileprefix', 'untitled', @ischar);
    addOptional(ip, 'location', pwd, @isdir);
    parse(ip, varargin{:});

    cd(ip.Results.location);
    theFigs = get(0, 'children');
    aFig = theFigs(1);
    figure(aFig);
    saveas(aFig, sprintf('%s.fig', ip.Results.fileprefix));
    saveas(aFig, sprintf('%s.pdf', ip.Results.fileprefix));
    saveas(aFig, sprintf('%s.eps', ip.Results.fileprefix));
end






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/saveFigures.m] ======  
