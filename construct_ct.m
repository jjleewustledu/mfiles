function construct_ct(varargin)
    %% CONSTRUCT_CT 
    %  @param local file construct_ct.json
    %  @return ensures creation of a well-defined ct.4dfp for every experiment of every local project
    
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository ophthalmic:~/MATLAB-Drive/mfiles,  
    %% developed on Matlab 9.5.0.1067069 (R2018b) Update 4.  Copyright 2019 John Joowon Lee.     
    
    projectsDir = getenv('PROJECTS_DIR');
    projectsDirs = {'CCIR_00754' 'CCIR_00559'};
    subjectsDir = getenv('SUBJECTS_DIR');
    ccj = jsondecode(fileread(fullfile(subjectsDir, 'construct_ct.json')));
    subjects = fields(ccj);
    
    fprintf('construct_ct:  find and build cts ###############################################');
    
    for is = 1:length(subjects)
        experiments = ccj.(subjects{is}).experiments; % select experiments set containing a ct        
        for ip = 1:length(projectsDirs)
            for ie = 1:length(experiments)
                % propose d
                d = fullfile(projectsDir, projectsDirs{ip}, cnda2ses(experiments{ie}), 'ct', '');
                if isfolder(d)
                    % found subject's ct
                    ccj.(subjects{is}).ct_dir = d;
                    ccj.(subjects{is}).experiment_with_ct = fileparts(d);
                    build_ct_4dfp(d);
                end
            end
        end
    end
    
    fprintf('construct_ct:  copy cts from subject ############################################');
    
    for is = 1:length(subjects)        
        copy_ct_4dfp(ccj.(subjects{is}), ccj.(subjects{is}))
        if isfield(ccj.(subjects{is}), 'aliases')
            aliases = fields(ccj.(subjects{is}).aliases); % subject aliases
            for ia = 1:length(aliases)
                copy_ct_4dfp(ccj.(subjects{is}), ccj.(subjects{is}).aliases.(aliases{ia}));
            end
        end
    end
end    

function s = cnda2ses(c)
    scell = strsplit(c, '_');
    s = ['ses-' scell{2}];
end

function ct = build_ct_4dfp(d)
    if isfile(fullfile(fileparts(d), 'ct.4dfp.hdr'))
        delete(fullfile(fileparts(d), 'ct.4dfp.*'))
    end
    system(sprintf('dcm_to_4dfp -b %s/ct -g %s/*.dcm', fileparts(d), d));
    ct = [d '.4dfp.*'];
end

function copy_ct_4dfp(sbj0, sbj) % subject with ct, subject alias
    projectsDir = getenv('PROJECTS_DIR');
    projectsDirs = {'CCIR_00754' 'CCIR_00559'};
    if ~isfield(sbj0, 'experiment_with_ct')
        return
    end
    src = sbj0.experiment_with_ct;
    ct_ast = fullfile(src, 'ct.4dfp.*');
    experiments = sbj.experiments;
    for ip = 1:length(projectsDirs)
        for ie = 1:length(experiments)
            % propose dst
            dst = fullfile(projectsDir, projectsDirs{ip}, cnda2ses(experiments{ie}), '');
            if isfolder(dst) && ~strcmp(src, dst)
                try
                    copyfile(ct_ast, dst, 'f');
                catch ME
                    warning(ME.message);
                end
            end                    
        end
    end 
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/construct_ct.m] ======  
