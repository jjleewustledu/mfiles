function append_timeframe(CCIR_path, varargin)
%% See also mlnipet.CommonTracerDirector for logical flow.

ip = inputParser;
addOptional(ip, 'timeInterval', [2790 3600], @isnumeric)
parse(ip, varargin{:})
timeIntervalStr = sprintf('%i-%i', ip.Results.timeInterval(1), ip.Results.timeInterval(2));


assert(isfolder(CCIR_path))
splitted = strsplit(CCIR_path, '/');
splitted = strsplit(splitted, '_');
TRACER = splitted{1};
assert(lstrfind(TRACER, {'FDG' 'OC' 'OO' 'HO'}))
tracer = lower(TRACER);

cd(fullfile(getenv('SINGULARITY_HOME'), CCIR_path, 'output', 'PET', ''))
TRACERifc = mlfourd.ImagingFormatContext([TRACER '.nii.gz']);
time61 = mlfourd.ImagingFormatContext(['a_itr-4_t-' timeIntervalStr 'sec_createDynamic2Carney_time61.nii.gz']);
TRACERifc.img(:,:,:,62) = time61.img;
TRACERifc.save;
mlbash(sprintf('fslroi %s %s %s', 'FDG', 'fdg', mlnipet.NipetBuider.FSL_ROI_ARGS))
traceric2 = mlfourd.ImagingContext2([tracer '.nii.gz']);
traceric2 = traceric2.flip(1);
traceric2.fileprefix = [traceric2.fileprefix 'r1'];
traceric2.filepath = fullfile(getenv('SINGULARITY_HOME'), CCIR_path);
traceric2.save
