function [sta, msg, ids] = filesystemOps(op, sources, dest, varargin)
    %% FILESYSTEMOPS extends ops such as copyfile, movefile to arrays of sources and a single destination   
    %  Usage:  [statuses,messages,messageids] = filesystemOps(op, sources [, dest, varargin]) 
    %           ^ same as copyfile                
    %             sta = 1 for success                         ^ function handle
    %             sta = 0 for failure                             ^ same as copyfile, but may be cell-arrays
    %                                                                        ^ string for single destination
    %                                                                              ^ auxiliary arguments to op
    %  See also:  copyfiles, movefiles, copyfile, movefile, myfileparts
    
    %% Version $Revision$ was created $Date$ by $Author$  
    %% and checked into svn repository $URL$ 
    %% Developed on Matlab 7.11.0.584 (R2010b) 
    %% $Id$ 

    assert(isa(op, 'function_handle'));
    assert(ischar(sources) || iscell(sources));
    if (ischar(sources)); sources = {sources}; end
    if (~exist('dest','var')); dest = pwd; end
    
    sta = {}; msg = {}; ids = {}; idx = 1;
    for s = 1:length(sources) %#ok<*FORFLG,*PFUNK>
        srcPath = myfileparts(sources{s}); 
        dlist   = dir(        sources{s}); 
        for d = 1:length(dlist)            
            if (~strcmp('.',  dlist(d).name) && ...
                ~strcmp('..', dlist(d).name)) 
                % reconstitute path
                [sta{idx},msg{idx},ids{idx}] = op(fullfile(srcPath, dlist(d).name), dest, varargin{:}); %#ok<*AGROW> 
                idx = idx + 1;
            end
        end
    end

end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/copyfiles.m] ======  
