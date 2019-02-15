function collectFSStats(subjids)
%% COLLECTFSSTATS ... 
%   
%  Usage:  collectFSStats(subject_id) 
%                         ^ 
%% Version $Revision: 1225 $ was created $Date: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ by $Author: jjlee $,  
%% last modified $LastChangedDate: 2012-08-23 16:04:28 -0500 (Thu, 23 Aug 2012) $ and checked into svn repository $URL: file:///Users/Shared/Library/SVNRepository/mpackages/mfiles/trunk/collectFSStats.m $ 
%% Developed on Matlab 7.13.0.564 (R2011b) 
%% $Id$ 
    import mlfourd.*;
    HEMIS      = {'lh' 'rh'};
    DESIKAN    = {'lateraloccipital'};
    DESTRIEUX  = {'G_front_inf-Opercular' 'G_precentral' 'G_postcentral' 'S_cingul-Marginalis' 'S_circular_insula_ant' 'S_circular_insula_inf'};
    EXPRESSION = ['\s*(?<numvert>\d*)\s*(?<surfarea>\d*)\s*(?<grayvol>\d*)\s*' ...
                     '(?<thickavg>\d+\.?\d*)\s*(?<thickstd>\d+\.?\d*)\s*(?<meancurv>\d+\.?\d*)\s*(?<gausscurv>\d+\.?\d*)\s*' ...
                     '(?<foldind>\d*)\s*(?<curvind>\d*)'];

               % numvert, surfarea, grayvol, thickavg, thickstd, meancurv, gausscurv, foldind, curvind
    if (~iscell(subjids) && ischar(subjids))
        subjids = {subjids};
    end
    for s = 1:length(subjids)
        %processSubject(subjids{s});        
        process4James(subjids{s});
    end
    
    
    
    % INTERNAL FUNCTIONS ======================================================================================
    
    function dat         = processSubject(subjid)
        pwd0         = pwd;
        xlsfname     = fullfile(pwd0, [subjid '.csv']);
        xlsfid       = fopen(xlsfname,  'w');  
        cd(fullfile(subjid, 'stats', ''));
        dat          = cell(2,length(DESIKAN) + length(DESTRIEUX));
        for h = 1:2 %#ok<*FORFLG,*PFUNK>
            contents = readfile(fullfile(pwd0, subjid, 'stats', [HEMIS{h} '.aparc.stats']));
            for d    = 1:length(DESIKAN)
                [dat{h,d}]                   = collectStructData(contents, DESIKAN{d}); %#ok<*PFPIE,*PFOUS,*PFNF>
            end
            contents = readfile(fullfile(pwd0, subjid, 'stats', [HEMIS{h} '.aparc.a2009s.stats']));
            for d2   = 1:length(DESTRIEUX)
                [dat{h, length(DESIKAN)+d2}] = collectStructData(contents, DESTRIEUX{d2}); %#ok<*PFNF>
            end
        end
        for h = 1:2
            for d3   = 1:length(DESIKAN)+length(DESTRIEUX)
                try
                    fprintf(xlsfid, '%s\n', dat{h,d3});
                catch ME
                    handerror(ME);
                end
            end
        end
        cd(pwd0);
        fclose(xlsfid);
    end % processSubject

    function dat         = process4James(subjid)
        pwd0      = pwd;
        jamesfile = fullfile(pwd0, [subjid '_forjames.csv']);   
        jamfid    = fopen(jamesfile, 'w');
        cd(fullfile(subjid, 'stats', ''));
        dat = struct('mca', [], 'pca', []);
        for h = 1:2 %#ok<*FORFLG,*PFUNK>
            contents   = readfile(fullfile(pwd0, subjid, 'stats', [HEMIS{h} '.aparc.stats']));
            dat(h).pca = collectData(contents, DESIKAN); %#ok<*PFPIE,*PFOUS,*PFNF>
            contents   = readfile(fullfile(pwd0, subjid, 'stats', [HEMIS{h} '.aparc.a2009s.stats']));            
            dat(h).mca = collectData(contents, DESTRIEUX); %#ok<*PFNF>
        end
        try
            fprintf(jamfid, '%s,, %g, %g,, %g, %g,, %g, %g,, %g, %g\n', ...
                    subjid, ...
                    dat(1).mca.grayvol, dat(1).mca.thickavg, dat(1).pca.grayvol, dat(1).pca.thickavg, ...
                    dat(2).mca.grayvol, dat(2).mca.thickavg, dat(2).pca.grayvol, dat(2).pca.thickavg);
        catch ME
            handerror(ME);
        end
        cd(pwd0);
        fclose(jamfid);
        fclose(xlsfid);
    end % processSubject

    function numbavg     = averageROIs(numbarr)
        if (1 == length(numbarr))
            numbavg = numbarr;
            return
        else
            numbavg = struct('grayvol',[],'thickavg',[]);
        end
        for n = 1:length(numbarr)
            numbavg.grayvol  = [numbavg.grayvol  numbarr(n).grayvol];
            numbavg.thickavg = [numbavg.thickavg numbarr(n).thickavg];
        end
        numbavg.grayvol  = mean(numbavg.grayvol);
        numbavg.thickavg = mean(numbavg.thickavg);
        assert(1 == length(numbavg));
        assert(1 == length(numbavg.grayvol));
        assert(1 == length(numbavg.thickavg));
    end % averageROIs

    function contents    = readfile(fname)
        contents = cell(1,1);
        try
            fid = fopen(fname);
            i   = 1;
            while 1
                tline = fgetl(fid);
                if ~ischar(tline),   break,   end
                contents{i} = tline;
                i = i + 1;
            end
            fclose(fid);
        catch ME
            disp(ME);
            warning('mfiles:IOErr', ['collectFSStats:  could not process file ' fname ' with fid ' num2str(fid)]);
        end
    end % readfile

    function datsing     = collectData(contents, roiname, dat)
        if (~exist('dat','var')); dat = []; end
        for d = 1:length(roiname)
             [~,dat] = collectStructData(contents, roiname{d}, dat);
        end
        datsing = averageROIs(dat); 
    end % collectData

    function [datcsv,names] = collectStructData(contents, structname, name0)
        if (~exist('name0','var')); name0 = []; end
        datcsv = '';
        try
            for j = 1:length(contents) %#ok<FORFLG>
                if (~isempty(    strfind(contents{j},  structname)))
                    [~, names] = regexpi(contents{j}, [structname EXPRESSION],'tokens','names');

                        names  = [name0, names];
                        datcsv    = sprintf('%s, %s, %s, %s, %s, %s, %s, %s, %s, %s', ...
                                 structname,     names.numvert,  names.surfarea, names.grayvol, ...
                                 names.thickavg, names.thickstd, names.meancurv, names.gausscurv, ...
                                 names.foldind,  names.curvind); 
                        fields = fieldnames(names);
                        for n = 1:length(fields)
                            if (~strcmp(fields{n}, structname))
                                names.(fields{n}) = str2double(names.(fields{n}));
                            end
                        end
                    return
                end
            end 
        catch ME2
            handexcept(ME2);
        end
    end % collectStructData
end % collectFSStats

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/collectFSStats.m] ======  
