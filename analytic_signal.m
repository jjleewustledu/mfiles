function as = analytic_signal(bold, ifv_mask, TR)
%%  ANALYTIC_SIGNAL mplements Raut, et al.  Global waves synchronize the brain's functional systems 
%   with fluctuating arousal.  Requires implementation of Hilbert transform, Butterworth filter model, 
%   zero-pole-gain to second-order sections model conversion, and aero-pole-gain to second-order sections
%   model conversion, all having same interfaces as hilbert(), butter(), zp2sos(), and filtfilt() 
%   from Matlab's Signal Processing Toolbox.
%   See also:
%     https://www.science.org/doi/10.1126/sciadv.abf2709
%     https://github.com/jjleewustledu/mlraut/tree/master
%
%   Args:
%     bold single; resize bold to be [N_times, N_voxels].  Exclude early bold frames not in steady-state.
%     ifv_mask single
%     TR single; repetition time of bold scan
%
%   Returns:
%     as complex; same size as bold.  Use abs(as) and angle(as) as desired.
%
%   Created 25-Apr-2023 13:04:04 by jjlee in repository
%   https://github.com/jjleewustledu/mfiles.
%   Developed on Matlab 9.14.0.2239454 (R2023a) Update 1 for MACI64.  Copyright 2023 John J. Lee.

arguments
    bold single
    ifv_mask logical
    TR single {mustBeScalarOrEmpty}
end
assert(2 == length(size(bold)), 'resize bold to be [N_times, N_voxels]')
assert(length(ifv_mask) == size(bold, 2), 'ensure bold has size [N_times, N_voxels]')
gs = median(bold, 2);
arousal = mean(bold(:, ifv_mask), 2); % Bandettini used mean; https://doi.org/10.1016/j.neuroimage.2022.119424

%  remove global signal, band-pass, center, and, rescale
bold = center_and_rescale(band_pass(bold - gs, TR));
arousal = center_and_rescale(band_pass(arousal - gs, TR));

%  form analytic signal normalized over bold duration
as = conj(hilbert(arousal)).*hilbert(bold);
as = normalize(as, TR);
end



%%  SUPPORTING FUNCS

function dat1 = band_pass(dat, TR)
%% Implements butter:  web(fullfile(docroot, 'signal/ref/butter.html?browser=F1help#bucsfmj')) .
%  See also web(fullfile(docroot, 'signal/ug/practical-introduction-to-digital-filtering.html')) .
%  Returns:
%      dat1; same num. type as dat

Fs = 1/TR;
lp_thresh = Fs/2;
hp_thresh = 2/size(dat,1);

[z,p,k] = butter(2, [hp_thresh, lp_thresh - eps('single')]/(Fs/2));
[sos,g] = zp2sos(z, p, k);
dat1 = filtfilt(sos, g, double(dat));
if isa(dat, 'single')
    dat1 = single(dat1);
end
if isa(dat, 'double')
    dat1 = double(dat1);
end
end

function arr = center_and_rescale(arr)
arr = arr - median(arr, 'all', 'omitnan');
if ~isreal(arr)
    d = mad(abs(arr), 1, 'all');
else
    d = mad(arr, 1, 'all');
end
arr = arr./d;
end

function arr = normalize(arr, TR)
arr = arr/abs(median(arr, 'all'));
arr = arr/(TR*size(arr, 1));
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de)
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/analytic_signal.m] ======
