function [carr,tf] = serialPLaif1Training()
%% SERIALPLAIF1TRAINING ... 
%  Usage:  [cell_array,tictoc_time] = serialPLaif1Training() 
%          ^ 
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.5.0.197613 (R2015a) 
%% $Id$ 

    import mlperfusion.*;
    if (strcmp(license, '847712'))
        sDir = '/Volumes/SeagateBP4/cvl/np755'; 
        diary(fullfile(sDir, sprintf('%s_diary_%s.log', mfilename, datestr(now, 30)))); 
    else
        sDir = '/scratch/jjlee/cvl/np755';
    end
    
    t0   = tic; 
    cd(sDir);
    dns  = {'mm01-007_p7267_2008jun16'};
    
    carr = cell(2,length(dns));
    for r = 1:length(carr)
        for d = 1:length(dns)
            try
                t1 = tic;
                fprintf('--------------------------------------------------------------------------------------\n');
                fprintf('%s:  is working with %s repetition %i\n', mfilename, dns{d}, r);
                ecatFilename = fullfile(sDir, dns{d}, 'bayesian_pet', 'p7267ho1.nii.gz');
                maskFilename = fullfile(sDir, dns{d}, 'bayesian_pet', 'aparc_a2009s+aseg_mask_on_p7267ho1_sumt.nii.gz');
                dcvFilename  = fullfile(sDir, dns{d}, 'bayesian_pet', 'p7267ho1.dcv');
                plaif1 = PLaif1Training.load(ecatFilename, maskFilename, dcvFilename);
                carr{r,d} = plaif1.estimateParameters;   

                fprintf('--------------------------Elapsed time is %g seconds---------------------------\n\n', toc(t1));
            catch ME
                handexcept(ME);
            end
        end
    end
    cd(sDir);
    save(fullfile(sDir, sprintf('%s_%s.mat', mfilename, datestr(now, 30))), '-v7.3');
    tf = toc(t0);
    
    if (strcmp(license, '847712'))
        diary off; 
    end
end
