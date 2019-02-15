%% STARTUP_COMMON script for matlab
%  Version $Revision$ was created $Date$ by $Author$
%  and checked into svn repository $URL$
%  $Id$

%% system-independent library initializations



%% Recover work directory & state

if ispref(         'StartupDirectory','LastWorkingDirectory')
     lwd = getpref('StartupDirectory','LastWorkingDirectory');
     try
         cd(lwd); %#ok<MCCD>
         if ispref(        'StartupState','LastWorkingState')
             lws = getpref('StartupState','LastWorkingState');
             if (LOAD_LAST_WORKING_STATE)
                 try
                     load(fullfile(lwd, lws));                
                 catch ME1
                     fprintf('Sorry, the last working state is not available :\n%s\n', fullfile(lwd, lws))
                     disp(getReport(ME1))
                 end
             end
         end
     catch ME
         fprintf('Sorry, the last working directory is not available :\n%s\n', lwd)
         disp(getReport(ME))
     end
end

%% Printing support

set(gcf, 'InvertHardCopy', 'off');

%% Parallel support at CHCP
%set(sched, 'ParallelSubmitFcn', {@parallelSubmitFcn, clusterHost, remoteDataLocation});

%% Import packages

import mlfourd.*;
import mlpublish.*;
import mlperf.*;
import mlfsl.*;
import mlentropy.*;
import mlpatterns.*;
disp('Disable autosave on exit by clearing variable AUTOSAVE_FILE.');
AUTOSAVE_FILE = 'autosaved';  %#ok<SNASGU>

