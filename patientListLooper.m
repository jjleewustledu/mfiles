function patientListLooper(fhandle, ptlist, varargin)

%% PATIENTLOOPER loope over a make-function specified by makeHandle
%  parfor is prohibited because of use of cd()
%
%  Usage:  patientLooper(ptfilt) 
%                        ^ string, *, ? wildcards allowed
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/patientListLooper.m $ 
%% Developed on Matlab 7.12.0.62 (R2011a) 
%% $Id$
if (~iscell(ptlist) && ischar(ptlist))
    ptlist = {ptlist};
    %patientLooper(ptlist, fhandle);
    %return
end
if (~exist('fhandle','var')); fhandle = @Np755Maker.makeTest; end
import mlfsl.* mlfourd.*;
matlabpool close force local
matlabpool local
makeHandle = fhandle; % makeRenamed; %.makeAll; % @makeFnirts; % FUNCTION-HANDLE TO LOOPED FUNCTION  
REUSE      = true;

%% PATIENT PATHS ---------------------------------------

pwd0       = pwd;
assert(numel(ptlist) > 0, 'ptlist was empty');
fprintf('patientLooper:  please confirm validity of the following patient paths\n');
fprintf('                from patientListLooper:  \n');
for p = 1:numel(ptlist) %#ok<FORPF>
fprintf('                %s\n', ptlist{p}); 
end
fprintf('\n');

%% LOOPER ----------------------------------------------

varargsin = cell(size(ptlist));
for v = 1:numel(varargsin) %#ok<FORFLG>
    varargsin{v,:} = varargin{:}; %#ok<PFBNS>
end
parfor idx = 1:length(ptlist)
    try
        if (lstrfind(ptlist{idx}, '_wu0'))
            fprintf('patientLooper:  Matlab exec:  %s(''%s'')\n\n', func2str(makeHandle), ptlist{idx});
            if (exist(fullfile(pwd0, 'fsl', ''), 'dir') && ~REUSE) % misplaced fsl folders
                rmdir(fullfile(pwd0, 'fsl', ''), 's');
            end
            makeHandle(ptlist{idx}, varargsin{idx,:});
            fprintf('\n\n');
        end
    catch MEloop
        handwarning(MEloop, ['patientLooper:  skipping patient-path -> ' ptlist{idx}]);
    end 
end % for








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/patientLooper.m] ======  
