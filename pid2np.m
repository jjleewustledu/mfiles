function np = pid2np(pid)
%% PID2NP, formerly named studyId, was used for the 2010 MRM paper to access MR/PET data from 2000.  
%  Usage:  np_string = pid2np(pid_string) 
%          np755 = pid2np('vc1234')
%          np755 = pid2np('p1234')
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

    NP287 = {'vc1535' 'vc1563' 'vc4103' 'vc4153' 'vc4336' ...
             'vc4354' 'vc4405' 'vc4420' 'vc4426' 'vc4437' ...
             'vc4497' 'vc4500' 'vc4520' 'vc4634' 'vc4903' ...
             'vc5591' 'vc5625' 'vc5647' 'vc5821' 'vc1645'};
    NP797 = {'p7118'  'p7146'  'p7153'  'p7189'  'p7191'  ...
             'p7194'  'p7216'  'p7217'  'p7219'  'p7229'  ...
             'p7230'  'p7243'  'p7248'  'p7257'  'p7260'  ...
             'p7266'  'p7267' }; % cell array of strings in a row
         
    if (strncmpi('np', pid, 2))
	 	np = pid; 
		return
	end
    for j = 1:length(NP797)
        if (strcmp(pid, NP797{j}))
            np = 'np797';
            return
        end
    end   
    for i = 1:length(NP287)
        if (strcmp(pid, NP287{i}) || strcmp(pid, vcnum_to_pnum(NP287{i})))
            np = 'np287';
            return
        end
    end    
    error('NIL:studyId:FunctionErr:functionBehaviorUndefined', ...
          ['studyId:  could not find a study-ID for patient ' pid]); 
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/pid2np.m] ======  
