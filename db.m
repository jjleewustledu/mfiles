
%% DB is a database of global parameters
%
%  Usage:  result = db(param, sw)
%
%          param:	char string label for requested object
%          sw:      switch specifying study or patient-ID
%          result:	returned object depends on requested param
%                   1 -> error condition
%
%  Created by John Lee on 2008-04-06.
%  Copyright (c) 2008 Washington University School of Medicine. All rights reserved.

function result = db(param, sw)

    dbase = mlfourd.DBase.getInstance;

    result = 1; % signifies error condition
    sw = dbase.sid;

    if (strcmpi('debug', param))
        result = true; return; end
    if (strcmpi('scaling', param))
        result = dbase.scaling; return; end
    if (strcmpi('block size', param))
        result = dbase.blockSize; return; end
    switch (sw)
        case 'np287'
            result = db_np287(param);
        case 'np797'
            result = db_np797(param);
        otherwise
            ME = MException('db:InputParamErr', ...
                ['switch -> ' sw ' was not recognized.']);
            throw(ME);
    end
end


