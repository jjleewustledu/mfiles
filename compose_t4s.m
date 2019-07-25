function sub_struct = compose_t4s()

    % build sub_struct
   
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

    % do t4_mul

    fv = mlfourdfp.FourdfpVisitor;
    ensuredir('resampling_restricted')

    tracers = {'fdg' 'ho' 'oo' 'oc'};
    for tra = tracers
        for itra = 1:length(sub_struct.tra_struct.(tra{1}))
            t4sub = sub_struct.tra_struct.(tra{1}){itra};
            [sesfold,t4ses] = find_sesfold_and_t4(t4sub, sub_struct, tra{1});
            fv.t4_mul(fullfile(sesfold, t4ses), t4sub, t4_ses2sub(t4sub))
            fv.t4_mul(t4_ses2sub(t4sub), 'fdg_avgr1_to_T1001r1_t4', ...
                      fullfile('resampling_restricted', [tracerdt(t4sub) '_to_T1001_t4']))
        end   
    end
end



function [sesfold,t4] = find_sesfold_and_t4(sub_t4, sub_struct, tra)
    for ses = asrow(fields(sub_struct.ses_struct))
        for tdt = asrow(sub_struct.ses_struct.(ses{1}).tra_struct.(tra)) % special for fdg
            if strcmpi(tra, 'fdg') && lstrfind(tracerdt(sub_t4), fdgdt(ses{1}))
                sesfold = strrep(ses{1}, '_', '-');
                t4 = sub_struct.ses_struct.(ses{1}).tra_struct.fdg{1};
                return
            end
            if strcmp(tracerdt(sub_t4), tracerdt(tdt{1}))
                sesfold = strrep(ses{1}, '_', '-');
                t4 = tdt{1};
                return
            end
        end
    end
end
function tdt = fdgdt(ses1)
    sesfold = strrep(ses1, '_', '-');
    for g = glob(fullfile(sesfold, 'fdgdt*.4dfp.hdr'))
        tdt = mybasename(g{1});
        if ~isempty(regexp(tdt, '^fdgdt\d+$', 'once'))
            return
        end
    end
    error('mfiles:RuntimeError', 'compose_t4s.fdgdt.sesfold is missing fdg')
end
function tdt = tracerdt(t4)
    tdt = strsplit(t4, '_');
    tdt = tdt{1};
end
function t4 = t4_ses2sub(t4_)
    t4 = sprintf('%s_ses2sub_t4', t4_(1:end-3));
end
