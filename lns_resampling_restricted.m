function lns_resampling_restricted()

ensuredir('resampling_restricted')
pwdsub = pwd;
fv = mlfourdfp.FourdfpVisitor();
exts = {'.4dfp.hdr' '.4dfp.ifh' '.4dfp.img' '.4dfp.img.rec'};

%cRB = mlfourdfp.CompositeT4ResolveBuilder();

for e = exts
    try
        mlbash(sprintf('ln -s %s/T1001%s %s/resampling_restricted/T1001%s', ...
            pwdsub, e{1}, pwdsub, e{1}))
    catch ME
        handwarning(ME)
    end
end

for t4 = asrow(glob('*dt*_to_op_fdg_avgr1_t4'))
    prefix = strsplit(t4{1}, '_');
    prefix = prefix{1};
    fv.t4_mul(t4{1}, 'fdg_avgr1_to_T1001r1_t4', ...
              fullfile('resampling_restricted', [prefix '_to_T1001_t4']))
end

for ses = asrow(glob('ses-E*'))
    for hdr = asrow(glob(fullfile(ses{1}, '*dt*.4dfp.hdr')))
        re = regexp(mybasename(hdr{1}), '^(?<prefix>(fdg|ho|oo|oc)dt(\d+|\d+_avgt))$', 'names');
        if ~isempty(re)
            for e = exts
                try
                    mlbash(sprintf('ln -s %s%s %s%s', ...
                        fullfile(pwdsub, ses{1}, re.prefix), e{1}, ...
                        fullfile(pwdsub, 'resampling_restricted', re.prefix), e{1}))
                catch ME
                    handwarning(ME)
                end
            end
        end
    end
        
end