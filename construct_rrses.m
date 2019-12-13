function construct_rrses(projID, sesID)

projPth = fullfile(getenv('SINGULARITY_HOME'), projID, '');
sesPth = fullfile(projPth, sesID, "");
assert(isfolder(projPth))
assert(isfolder(sesPth))
OTRACERS = {'OC' 'OO' 'HO'};

tic
pwd0 = pushd(sesPth);
for t = OTRACERS    
    globbed = glob([t{1} '*-Converted-AC']);
    globbed = cellfun(@(x) x(1:end-1), globbed, 'UniformOutput', false);
    for g = asrow(globbed)
        construct_resampling_restricted(fullfile(projID, sesID, g{1}))
    end
end
popd(pwd0)
toc
