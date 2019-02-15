function cout = squeezeCell(cin)
%% SQUEEZECELL reduces a tree of cell-arrays to a linear cell-array without branches; top level must be a row/col; 
%              performes recursion; returns rows
%   
%  Usage:  cout = squeezeCell(cin) 
%          ^ linear cell-array
%                             ^ branched cell-array
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

if (~iscell(cin))
    
    cout = {cin};
    return
else

    switch (numel(cin))
        case 1

            cout = squeezeCell(cin{1});
            return;
        otherwise

            cinRemain = cell(1, numel(cin)-1);
            for r = 2:numel(cin)
                cinRemain{r-1} = cin{r};
            end
            cout = horzcat(squeezeCell(cin{1}), squeezeCell(cinRemain));
            return
    end
end % if-else


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/squeezeCell.m] ======  
