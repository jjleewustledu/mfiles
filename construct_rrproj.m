function construct_rrproj(projID)

tic
projPth = fullfile(getenv('SINGULARITY_HOME'), projID, '');
assert(isfolder(projPth))

pwdp = pushd(projPth);
globbed_ses = glob('ses-E*');
globbed_ses = cellfun(@(x) x(1:end-1), globbed_ses, 'UniformOutput', false);
for s = asrow(globbed_ses)
    sesID = s{1};
    sesPth = fullfile(projPth, sesID, "");
    assert(isfolder(sesPth))
    OTRACERS = {'OC' 'OO' 'HO'};
    pwds = pushd(sesPth);
    for t = OTRACERS    
        try
            globbed_tra = glob([t{1} '*-Converted-AC']);
            globbed_tra = cellfun(@(x) x(1:end-1), globbed_tra, 'UniformOutput', false);
            for g = asrow(globbed_tra)
                construct_resampling_restricted(fullfile(projID, sesID, g{1}))
            end
        catch ME
            handwarning(ME)
        end
    end
    popd(pwds)
end
popd(pwdp)

toc
