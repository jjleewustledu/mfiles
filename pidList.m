%% PIDLIST tabulates patient-ids, returning a specified idiom 
%
%  USAGE:  idiom = pidList(id, request)
%
%          id is an integer index or string, e.g., 'vc1535'
%          id in range returns a string for the PID
%          id < 1 returns a cell array of strings in a row for all the PIDs
%          id > length of PIDs returns the last PID from 
%                the internal cell array
%          request is 's', 'string', 'i', 'integer', specifying the format of the output
%          idiom is a string for integer id and an integer for string id 
%
%  SYNOPSIS:
%
%  SEE ALSO:  'strings', 'Cell Arrays of Strings' & 'strings, cells arrays of' in Matlab help.
%
%  N.B.:
%
%  S = [S1 S2 ...] concatenates character arrays
%  S = strcat(S1, S2, ...) concatenates strings or cell arrays of strings
%  You can convert between character array and cell array of strings using char and cellstr.   
%  ischar(S) tells if S is a string variable. iscellstr(S) tells if S is a
%  cell array of strings.
%
%  $Id$
%________________________________________________________________________

function idiom = pidList(id, request)

    PIDS =  { 'vc1535' 'n/a'    'vc4103' 'n/a'    'vc4336' ...
              'vc4354' 'vc4405' 'vc4420' 'vc4426' 'vc4437' ...
              'vc4497' 'vc4500' 'vc4520' 'vc4634' 'vc4903' ...
              'vc5591' 'vc5625' 'n/a'    'vc5821'          ...
              'p7118'  'p7153'  'p7146'  'p7189'  'p7191'  ...
              'p7194'  'p7217'  'p7219'  'p7229'  'p7230'  ...
              'p7243'  'p7248'  'p7257'  'p7260'  'p7266'  ...
              'p7267'  'p7270'  'p7321'  'p7335'  'p7336'  ...
              'p7338'  'p7365' }; 
         
    HOME0 = { '' '' '' '' '' ...
              '' '' '' '' '' ...
              '' '' '' '' '' ...
              '' '' '' ''    ...
              'wu001_' 'wu002_' 'wu003_' 'wu005_' 'wu006_' ...
              'wu007_' 'wu009_' 'wu010_' 'wu011_' 'wu012_' ...
              'wu014_' 'wu015_' 'wu016_' 'wu017_' 'wu018_' ...
              'wu019_' 'wu021_' 'wu024_' 'wu026_' 'wu027_' ...
              'wu028_' 'wu030_' };
    HOME1 = { ''    ''    '' ...
              '' '' '' '' '' ...
              '' '' '' '' '' ...
              '' ''    ''    ...
              '_2007oct16' '_2008jan16' '_2008jan4'  '_2008mar12' '_2008mar13' ...
              '_2008mar14' '_2008apr14' '_2008apr23' '_2008apr28' '_2008apr29' ...
              '_2008may21' '_2008may23' '_2008jun4'  '_2008jun9'  '_2008jun16' ...
              '_2008jun16' '_2008jun18' '_2008sep8'  '_2008oct21' '_2008oct21' ...
              '_2008oct30' '_2009jan6' };
    NNP287 = 16;
    NNP797 = 22;
    
    if (0 == nargin)
        idiom = PIDS; return; end
    if (1 == nargin)
        if (isnumeric(id)); request = 'char';
        else                request = 'double'; end
        
    end
    
    switch (lower(request))
        case {'char', 'string'}
            switch (class(id))
                case 'char'
                    idiom = id; 
                    return; 
                case {'double', 'single', 'float', 'integer', 'int32', 'int16', 'uint8'}
                    if (id < 1 || id > length(PIDS))
                        idiom = '';
                    else
                        idiom = PIDS{id};
                    end
                    return;
                otherwise
                    error('mfiles:InputParamsErr', ...
                         ['pidList could not recognize class(id) -> ' class(id)]);
            end            
            
        % legacy support
        case {'numeric', 'double', 'single', 'float', 'integer', 'int32', 'int16', 'uint8'}
            switch (class(id))
                case 'char'
                    for p = 1:length(PIDS)
                        if (strcmpi(id, PIDS{p}))
                            idiom = p; 
                            break;
                        end
                    end
                    return;
                case {'double', 'single', 'float', 'integer', 'int32', 'int16', 'uint8'}
                    idiom = id;
                    return;
                otherwise
            end
        case 'home'
            switch (class(id))
                case 'char'
                    q = 0;
                    for p = 1:length(PIDS)
                        if (strcmpi(id, PIDS{p}))
                            q = p; 
                            break;
                        end
                    end
                case {'double', 'single', 'float', 'integer', 'int32', 'int16', 'uint8'}
                    q = id;
                otherwise
            end
            idiom = [HOME0{q} PIDS{q} HOME1{q}];
        case 'studyid'
            charpid = pidList(id, 'char');
            if (isin(charpid, PIDS(1:NNP287)))
                idiom = 'np287'; return;
            elseif (isin(charpid, PIDS(NNP287+1:NNP287+NNP797)))
                idiom = 'np797'; return;
            else
                error('mfiles:InputParamsErr', ...
                     ['pidList could not recognize ' charpid]);
            end
        case 'basepath'
            idiom = [db('basepath', pidList(id, 'studyid')) pidList(id, 'home')];
        case 'MR'
        case 'PET'
        case {'ROIs', 'masks'}
        case 'AIFs'
        case 'Bayes'
        case 'MLEM'
        case 'hdrinfo'
        case 'figures'
        otherwise
            error('mfiles:InputParamsErr', ...
                 ['pidList.request was not recognized -> ' request]);
    end
    
    %% ISIN determines whether a element is in the set
    %  Usage:   truthval = isin(elemnt, set)
    %           elemnt:    char string
    %           set:       cell array
    function truthval = isin(elemnt, set)
        for e = 1:length(set)
            if (strcmpi(elemnt, set{e}))
                truthval = true; 
                return; 
            end
        end
        truthval = false;
    end % internal function isin

end % function pidList
    

