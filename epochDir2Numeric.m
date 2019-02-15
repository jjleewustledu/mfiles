function n = epochDir2Numeric(d)
%% EPOCHDIR2NUEMRIC ... 
%  @param d is directory name of epoch; e.g., E1, E1to2, ...
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2017 John Joowon Lee. 

    assert(strcmp(d(1), 'E'));
    if (~lstrfind(d, 'to'))
        n = str2double(d(2:end));
        return
    else
        posTo  = strfind(d, 'to');
        assert(~isempty(posTo));
        n = str2double(d(2:posTo-1)):str2double(d(posTo+2:end));
        return
    end
end






