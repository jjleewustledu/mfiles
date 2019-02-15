
%% ENSUREPID examines an idiom for the patient identifier & returns
%            a string, pid, or an integer, p
%
%  USAGE:  [pid, p] = ensurePid(idiom, studyid)
%
%			idiom:	 int or string, e.g., 3 or 'vc4103' or 'p7366'
%			pid:	 string
%			p:		 int
%
%__________________________________________________________________________

function [pid, p] = ensurePid(idiom, studyid) 

    pid = ''; 
	p   = 0;
    
    switch (nargin)
        case 1
            studyid = '';
        case 2
        otherwise
            error('mfiles:InputParamsErr', ...
                 ['ensurePid does not support nargin -> ' num2str(nargin)]);
    end
    
    switch (class(idiom))
        case 'char'
            pid = idiom;
            p   = pidList(idiom, 'double');
        case 'double'
            p   = idiom;
            pid = pidList(idiom, 'char');
        otherwise
            error('mfiles:InputParamsErr', ...
                 ['ensurePid could not recognize class(idiom) -> ' class(idiom)]);
    end
    
    % checks on returned values    
	assert(ischar(pid)  && numel(pid) > 0);
	assert(isnumeric(p) && p          > 0);
	
