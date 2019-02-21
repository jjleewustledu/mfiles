function patientLooper(ptfilt, fhandle)

%% PATIENTLOOPER loope over a make-function specified by makeHandle
%  parfor is prohibited because of use of cd()
%
%  Usage:  patientLooper(ptfilt) 
%                        ^ string, *, ? wildcards allowed
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 7.12.0.62 (R2011a) 
%% $Id$ 
if (~exist('fhandle','var')); fhandle = @Np755Maker.makeTest; end
import mlfsl.* mlfourd.*;
parpool close force local
parpool local
makeHandle = fhandle; % makeRenamed; %.makeAll; % @makeFnirts; % FUNCTION-HANDLE TO LOOPED FUNCTION  
REUSE = true;

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
            if (exist(fullfile(pwd0, 'fsl', ''), 'dir') && ~REUSE) % misplaced fsl folders
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
