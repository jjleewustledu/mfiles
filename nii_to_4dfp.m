function nii_to_4dfp()
%% NII_TO_4DFP ... 
%  Usage:  nii_to_4dfp() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 9.0.0.341360 (R2016a) 
%% $Id$ 

tracers = {'gluc' 'ho'};

cd(fullfile(getenv('ARBELAEZ'), 'GluT', ''));
dt = mlsystem.DirTool('p*_JJL');
for d = 1:dt.length
    for s = 1:2
        for t = 1:length(tracers)
            cd(fullfile(dt.fqdns{d}, 'PET', sprintf('scan%i', s), ''));
            r = '';
            try
                fp    = sprintf('%s%s%i', str2pnum(dt.dns{d}), tracers{t}, s);
                [~,r] = dbbash(sprintf('fslchfiletype ANALYZE %s.nii.gz', fp));
                [~,r] = dbbash(sprintf('analyzeto4dfp %s.hdr',            fp)); %#ok<ASGLU>
            catch ME
                sprintf('nii_to_4dfp:  dt.fqdns{d}->%s s->%i tracer{t}->%s\n', dt.fqdns{d}, s, tracers{t});
                sprintf('          r:  %s\n', r);
                handexcept(ME);
            end
        end
    end
end







% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/nii_to_4dfp.m] ======  
