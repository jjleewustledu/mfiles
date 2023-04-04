function runSimpleFung2013(pet_dyn, opts)
%% RUNSIMPLEFUNG2013 is a convenience function for using class mlaif.Fung2013.
%  mlaif_unittest.Test_AbstractFung2013 provides tests of many use cases.
%
%  Usage:
%  >> cd('/home/usr/jjlee/Singularity/SimpleProject/sub-1179204')
%  >> runSimpleFung2013( ...
%         '1179204_v1_FDG.nii.gz', ...
%         mpr='1179204_v1_mpr.nii.gz', ...
%         mra='1179204_v1_mra.nii.gz', ...
%         mpr_coords={}, ...
%         mra_coords={[309 234 16]+1, [263 266 96]+1}, ...
%         taus=[5*ones(1,24) 20*ones(1,9) 60*ones(1,10) 300*ones(1,9)], ...
%         needs_reregistration=false, ...
%         verbose=2, ...
%         disp_only=false, ...
%         use_cache=false)
%
%  Required Arg:
%     pet_dyn:  dynamic PET, e.g., '/full/path/to/1179204_v1_FDG.nii.gz', or
%               any argument understood by mlfourd.ImagingContext2.
%
%  Required Named Args:
%     mpr:         e.g., 'relative/path/to/1179204_v1_mpr.nii.gz'.
%     mra:         e.g., '1179204_v1_mra.nii.gz'.
%     mpr_coords:  two diagonal corners of bounding box for one carotid segment using MPR, 
%                  e.g., {}, omits using MPR for Fung's method.  
%     mra_coords:  two diagonal corners of bounding box for one carotid segment using MRA, 
%                  e.g., {[309 234 16] + 1, [263 266 96] + 1}.
%                  N.B.:  one of mpr_coords or mra_coords must be nonempty.
%
% Optional Named Args:
%     tracer:      tracer name, e.g., 'FDG', 'S1P1', 'ASEM', 'AZAN'.  Default is guessed from pet_dyn_fn.
%     taus:        frame durations used to plot IDIFs in time, 
%                  e.g., [5*ones(1,24) 20*ones(1,9) 60*ones(1,10) 300*ones(1,9)];
%                  default plots IDIFs w.r.t. frame index.
%     needs_reregistration:  set to true, if cervical carotid is sought and has moved between anat and pet;
%                            default is false.
%     verbose:               0 (silent), 1 (plot final IDIF), 2 (plot more QC)
%     disp_only:             disp internal configurations without running; default is false.
%     use_cache:             use cache of existing calculations of segmentation, centerline.  
%                            Check with command "!ls -l *.mat".
%     k:                     number of knots used for b-splines.
%     t:                     knot positions used by b-splines.
%
%  Returns:
%     plots for QC for verbose > 0
%     products stored on filesystem, same folder as pet_fn.  
%
%  Created 07-Mar-2023 00:18:28 by jjlee in repository
%  /Users/jjlee/MATLAB-Drive/mfiles.
%  Developed on Matlab 9.13.0.2126072 (R2022b) Update 3 for MACI64.  Copyright 2023 John J. Lee.

arguments
    pet_dyn 
    opts.mpr {mustBeNonempty} = [];
    opts.mra {mustBeNonempty} = [];
    opts.mpr_coords cell = {}
    opts.mra_coords cell = {}
    opts.tracer {mustBeTextScalar} = ''
    opts.taus double = []
    opts.needs_reregistration logical = false
    opts.verbose double = 0
    opts.disp_only logical = false
    opts.use_cache logical = false
    opts.k double {mustBeScalarOrEmpty} = 4
    opts.t double {mustBeVector} = [0 0 0 0.2 0.4 0.6 0.8 1 1 1] 
end

% build mlpipeline.SimpleMediator
pet_dyn_ic = mlfourd.ImagingContext2(pet_dyn);
smed = mlpipeline.SimpleMediator(pet_dyn_ic);
smed.bids.t1w_ic = opts.mpr;
smed.bids.tof_ic = opts.mra;

% build mlpipeline.SimpleRegistry
reg = mlpipeline.SimpleRegistry.instance('reset');
if ~isempty(opts.tracer)
    reg.tracer = opts.tracer;
elseif contains(pet_dyn_ic.fileprefix, 'FDG', IgnoreCase=true)
    reg.tracer = 'FDG';
elseif contains(pet_dyn_ic.fileprefix, 'S1P1', IgnoreCase=true)
    reg.tracer = 'S1P1';
elseif contains(pet_dyn_ic.fileprefix, 'ASEM', IgnoreCase=true)
    reg.tracer = 'ASEM';
elseif contains(pet_dyn_ic.fileprefix, 'AZAN', IgnoreCase=true)
    reg.tracer = 'AZAN';
else
    error('mfiles:valueError', 'Uninterpretable tracer -> %s', opts.tracer)
end
reg.tausMap = containers.Map;
if ~isempty(opts.taus)
    reg.tausMap(reg.tracer) = opts.taus;
else
    reg.tausMap(reg.tracer) = [];
end

% construct mlaif.Fung2013
if isempty(opts.mpr_coords) && isempty(opts.mra_coords)
    error('mfiles:valueError', 'at least one of mpr_coords or mra_coords is needed')
end
if ~isempty(opts.mpr_coords)
    for c = 1:length(opts.mpr_coords)
        try
            fung2013 = mlaif.Fung2013.createForT1w( ...
                bids=smed, ...
                coord1=opts.mpr_coords{c}(1,:), ...
                coord2=opts.mpr_coords{c}(2,:), ...
                timesMid=cumsum(smed.taus()), ...
                needs_reregistration=opts.needs_reregistration, ...
                verbose=opts.verbose);    
            if opts.disp_only
                disp(pet_dyn_ic)
                disp(smed.bids.t1w_ic)
                disp(smed.taus(opts.tracer))
                disp(fung2013)
                return
            end
            fung2013.call(pet_dyn=pet_dyn_ic, use_cache=opts.use_cache, k=opts.k, t=opts.t);
        catch ME
            handwarning(ME)
        end
    end
end
if ~isempty(opts.mra_coords)
    for c = 1:length(opts.mra_coords) % ~40 GiB each core
        try
            fung2013 = mlaif.Fung2013.createForTof( ...
                bids=smed, ...
                coord1=opts.mra_coords{c}(1,:), ...
                coord2=opts.mra_coords{c}(2,:), ...
                timesMid=cumsum(smed.taus()), ...
                needs_reregistration=opts.needs_reregistration, ...
                verbose=opts.verbose);    
            if opts.disp_only
                disp(pet_dyn_ic)
                disp(smed.bids.t1w_ic)
                disp(smed.bids.tof_ic)
                disp(smed.taus(opts.tracer))
                disp(fung2013)
                return
            end
            fung2013.call(pet_dyn=pet_dyn_ic, use_cache=opts.use_cache, k=opts.k, t=opts.t);
        catch ME
            handwarning(ME)
        end
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/runSimpleFung2013.m] ======  
