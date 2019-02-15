function repairFrameNumbersInImgRecHYGLY()
%% REPAIRFRAMENUMBERSINIMGRECHYGLY ... 
%  Usage:  repairFrameNumbersInImgRecHYGLY() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.1.0.441655 (R2016b) 
%% $Id$ 

studyd = mlraichle.StudyData;
pwd0 = pushd(studyd.subjectsDir);

import mlsystem.*;
eSess = DirTool('HYGLY*');
for iSess = 1:length(eSess.dns)
    eVisit = DirTool(fullfile(eSess.fqdns{iSess}, 'V*'));
    for iVisit = 1:length(eVisit.dns)
        ac = fullfile(eSess.fqdns{iSess}, eVisit.dns{iVisit}, sprintf('FDG_%s-AC', eVisit.dns{iVisit}), '');
        imgrec = fullfile(ac, sprintf('fdg%sr1_on_resolved.4dfp.img.rec', lower(eVisit.dns{iVisit})));
        fprintf('imgrec -> %s, lexists -> %i\n', imgrec, double(lexist(imgrec, 'file')));
        mlraichle.T4ResolveUtilities.repairFrameNumbersInImgRec(imgrec);
    end
end

popd(pwd0);





% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/repairFrameNumbersInImgRecHYGLY.m] ======  
