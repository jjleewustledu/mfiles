function sub_struct = compose_t4s()
    %% COMPOSE_T4S
    
    % build sub_struct := {
    %   "tra_struct" = { 
    %     "fdg" = { "fdgdt<datetime>_to_op_fdg_avgr1_t4" }, 
    %     "ho"  = { "hodt<datetime>_to_op_fdg_avgr_t4", ... }, 
    %     "oc"  = { "ocdt<datetime>_to_op_fdg_avgr1_t4", ... }, ...
    %   },
    %   "ses_struct" = {
    %     "ses-E00001" = {
    %       "tra_struct" = {
    %         "fdg" = { "fdg_avgr1_to_op_fdg_avgr1_t4" }, 
    %         "ho"  = { "hodt<datetime>_to_op_fdg_avgr_t4", ... }, 
    %         "oc"  = { "ocdt<datetime>_to_op_fdg_avgr1_t4", ... }, ...
    %   },
    %     "ses-E00002" = {
    %       "tra_struct" = {
    %         "fdg" = { "fdgdt<datetime>_to_op_fdg_avgr1_t4" }, 
    %         "ho"  = { "hodt<datetime>_to_op_fdg_avgr_t4", ... }, 
    %         "oc"  = { "oc_avgr1_to_op_oc_avgr1_t4" }, ...
    %     }
    %   }
    % }
   
    load('t4_obj.mat', 't4_obj')
    sub_struct = struct('tra_struct', t4_obj);
    for ses = asrow(glob('ses-E*'))
        try
            load(fullfile(ses{1}, 't4_obj.mat'), 't4_obj')
            ses_field = strrep(strrep(ses{1}, '/', ''), '-', '_');        
            sub_struct.ses_struct.(ses_field).tra_struct = t4_obj;        
        catch ME
            handwarning(ME)
        end
    end

    % compose t4s:  tracer -> session -> subject -> T1001

    fv = mlfourdfp.FourdfpVisitor;
    ensuredir('resampling_restricted')
    tracers = {'fdg' 'ho' 'oo' 'oc'};
    for tra = tracers
        for itra = 1:length(sub_struct.tra_struct.(tra{1}))
            t4sub = sub_struct.tra_struct.(tra{1}){itra};
            [sesfold,t4ses] = find_sesfold_and_t4ses(t4sub, sub_struct, tra{1});
            fv.t4_mul(t4sub, fullfile(sesfold, t4ses), t4_ses2sub(t4sub))
            fv.t4_mul(t4_ses2sub(t4sub), 'fdg_avgr1_to_T1001r1_t4', ...
                      fullfile('resampling_restricted', [tracerdt(t4sub) '_to_T1001_t4']))
        end   
    end
end


function [sesfold,t4] = find_sesfold_and_t4ses(sub_t4, sub_struct, tra)
    %% @return sesfolder and t4 filename
    for ses = asrow(fields(sub_struct.ses_struct))       
        assert(~isempty(sub_struct.ses_struct.(ses{1}).tra_struct.(tra)), ...
            'mfiles:RuntimeError', 'compose_t4s.find_sesfold_and_t4ses() received empty tracer list')
        for tdt = asrow(sub_struct.ses_struct.(ses{1}).tra_struct.(tra))
            if issingleton(sub_struct.ses_struct.(ses{1}).tra_struct.(tra)) && ...
                    lstrfind(tracerpref(sub_t4), singletondt(tra, ses{1})) % found matching
                sesfold = strrep(ses{1}, '_', '-');
                t4 = sub_struct.ses_struct.(ses{1}).tra_struct.(tra){1}; % t4 ~ 'tracer_avgr1_to_op_tracer_avgr1_t4'
                return
            end
            if strcmp(tracerpref(sub_t4), tracerpref(tdt{1})) % found matching
                sesfold = strrep(ses{1}, '_', '-');
                t4 = tdt{1};
                return
            end
        end
    end
end
function [sesfold,t4] = find_sesfold_and_t4ses_(sub_t4, sub_struct, tra)
    %% @return sesfolder and t4 filename
    for ses = asrow(fields(sub_struct.ses_struct))       
        assert(~isempty(sub_struct.ses_struct.(ses{1}).tra_struct.(tra)), ...
            'mfiles:RuntimeError', 'compose_t4s.find_sesfold_and_t4ses() received empty tracer list')
        if issingleton(sub_struct.ses_struct.(ses{1}).tra_struct.(tra))
            % special case for singleton sub_struct.ses_struct.(ses{1}).tra_struct.(tra)
            
            if lstrfind(tracerpref(sub_t4), singletondt(tra, ses{1})) % found matching
                sesfold = strrep(ses{1}, '_', '-');
                t4 = sub_struct.ses_struct.(ses{1}).tra_struct.(tra){1}; % t4 ~ 'tracer_avgr1_to_op_tracer_avgr1_t4'
                return
            end
        else
            for tdt = asrow(sub_struct.ses_struct.(ses{1}).tra_struct.(tra))
                if strcmp(tracerpref(sub_t4), tracerpref(tdt{1})) % found matching
                    sesfold = strrep(ses{1}, '_', '-');
                    t4 = tdt{1};
                    return
                end
            end
        end
    end
end
function [sesfold,t4] = find_sesfold_and_t4ses__(sub_t4, sub_struct, tra)
    for ses = asrow(fields(sub_struct.ses_struct))
        for tdt = asrow(sub_struct.ses_struct.(ses{1}).tra_struct.(tra)) % special for fdg
            if strcmpi(tra, 'fdg') && lstrfind(tracerpref(sub_t4), fdgdt(ses{1}))
                sesfold = strrep(ses{1}, '_', '-');
                t4 = sub_struct.ses_struct.(ses{1}).tra_struct.fdg{1};
                return
            end
            if strcmp(tracerpref(sub_t4), tracerpref(tdt{1}))
                sesfold = strrep(ses{1}, '_', '-');
                t4 = tdt{1};
                return
            end
        end
    end
end
function tdt = fdgdt(ses1)
    %% @returns first fdgdt12345678 object found in ses1
    sesfold = strrep(ses1, '_', '-');
    for g = glob(fullfile(sesfold, 'fdgdt*.4dfp.hdr'))
        tdt = mybasename(g{1});
        if ~isempty(regexp(tdt, '^fdgdt\d+$', 'once'))
            return
        end
    end
    error('mfiles:RuntimeError', 'compose_t4s.fdgdt.sesfold is missing fdg')
end
function tf = issingleton(tra_list)
    tf = length(tra_list) == 1;
end
function tdt = singletondt(tra, ses1)
    %% @returns first tracerdt12345678 object found in ses1
    sesfold = strrep(ses1, '_', '-');
    for g = glob(fullfile(sesfold, [tra 'dt*.4dfp.hdr']))
        tdt = mybasename(g{1});
        if ~isempty(regexp(tdt, sprintf('^%sdt\\d+$', tra), 'once'))
            return
        end
    end
    error('mfiles:RuntimeError', 'compose_t4s.fdgdt.sesfold is missing fdg')
end
function tdt = tracerdt(t4)
    %% @returns tracerdt12345678 from some tracerdt12345678_to<...>_t4
    t4fp = tracerpref(t4);
    if regexp(t4fp, '^[a-z]+dt\d+$', 'once')
        tdt = t4fp;
        return
    end
    
    % find associated datetime
    g = glob([t4fp 'dt*.4dfp.*']);
    tdt = strsplit(g{1}, '.');
    tdt = tdt{1};
end
function tdt = tracerpref(t4)
    %% @returns tracerdt12345678 from some tracerdt12345678_to<...>_t4
    tdt = strsplit(t4, '_');
    tdt = tdt{1};
end
function t4 = t4_ses2sub(t4_)
    t4 = sprintf('%s_ses2sub_t4', t4_(1:end-3));
end
