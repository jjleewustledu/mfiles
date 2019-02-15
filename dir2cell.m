function [files,folds] = dir2cell(tokeep, totoss)
%% DIR2CELL extends the dir function to accept & return cells; returns dirfolder separately
%   
%  Usage:  [filemae_cells,folder_cells] = dir2cell(tokeep, totoss) 
%                                                  ^       ^ filename string, wildcards allowed, cell-arrays ok
%                                                            preserves path information
%  Uses:   recursion, dir
%  Unsupported:  parfor
%
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

    files = {};
    folds = {};
    if (~exist('totoss','var'))
        totoss = {'.' '..'}; 
    else
        totoss = dir2cell(totoss);
    end
    
    switch(class(tokeep))
        case 'cell'
            for f = 1:length(tokeep) 
                
                % RECURSION
                [files1,dlist1] = dir2cell(tokeep{f});    
                 files          = horzcat(files, files1); %#ok<*AGROW>
                 folds          = horzcat(folds, dlist1); 
            end
        case 'char'
            [pth2keep,~,~] = fileparts(tokeep);
            dlist  = dir(tokeep);
                c  = 1; c1 = 1;
            for d  = 1:length(dlist) %#ok<FORFLG,*PFUNK> 
                if (~dlist(d).isdir)
                    files{c}  = fullfile(pth2keep, dlist(d).name); %#ok<*PFPIE>
                          c   = c + 1; 
                else
                    folds{c1} = fullfile(pth2keep, dlist(d).name);
                          c1  = c1 + 1;
                end
            end
            if (~isempty(files) && ~isempty(totoss))
                files = setdiff(files, totoss);
            end
            if (~isempty(folds) && ~isempty(totoss))
                folds = setdiff(folds,  totoss);
            end
        otherwise
            throw(MException('mfiles:UnsupportedType', ...
                  sprintf('dir2cell.tokeep had unsupported type %s\n', class(tokeep))));
    end

end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/dir2cell.m] ======  
