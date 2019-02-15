function patientLooper2(ptfilt)

%% PATIENTLOOPER loope over a make-function specified by makeHandle
%  parfor is prohibited because of use of cd()
%
%  Usage:  patientLooper(ptfilt) 
%                        ^ string, *, ? wildcards allowed
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/patientLooper2.m $ 
%% Developed on Matlab 7.12.0.62 (R2011a) 
%% $Id$ 
import mlfsl.* mlfourd.*;
%matlabpool close force local
%matlabpool local
makeHandle = @Np755Maker.makeRename; % @makeFnirts; %% FUNCTION-HANDLE TO LOOPED FUNCTION  

%% PATIENT PATHS ---------------------------

pwd0       = pwd;
if (~lstrfind(ptfilt, '*')); ptfilt = [ptfilt '*']; end
[~,ptpths] = dir2cell(ptfilt);
assert(numel(ptpths) > 0, 'ptpths was empty');
fprintf('patientLooper:  please confirm validity of the following patient paths\n');
fprintf('                from patientLooper(''%s''):\n', ptfilt);
for p = 1:numel(ptpths) %#ok<FORPF>
fprintf('                %s\n', ptpths{p}); 
end
fprintf('\n');

%% LOOPER ----------------------------------------------

for idx = 1:length(ptpths) %#ok<FORPF>
    try
        if (~lstrfind(ptpths{idx}, '_wu0'))
            fprintf('patientLooper:  Matlab exec:  %s(''%s'')\n\n', func2str(makeHandle), ptpths{idx});
            if (exist(fullfile(pwd0, 'fsl', ''), 'dir')) % misplaced fsl folders
                rmdir(fullfile(pwd0, 'fsl', ''), 's');
            end
            makeHandle(ptpths{idx}); 
            fprintf('\n\n');
        end
    catch MEloop
        handwarning(MEloop, ['patientLooper:  skipping patient-path -> ' ptpths{idx}]);
    end 
    cd(pwd0); %#ok<*MCCD>
end % for








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/patientLooper.m] ======  
