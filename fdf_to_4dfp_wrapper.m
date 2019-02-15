%
% Usage:    [img ifh] = fdf_to_4dfp_wrapper(path0, metric)
%
%

function [img ifh] = fdf_to_4dfp_wrapper(path0, metric, pid)

    path       = fullfile(path0, '/images/');

    fprintf(['fdf_to_4dfp_wrapper:  path -> %s;\n'], path);

    scals0     = [1.72 1.72 6.50];
    lens0      = [128 128 13];
    scals      = [scals0(1) scals0(2) scals0(3) 5];
    lens       = [lens0(1)  lens0(2)  lens0(3)  1];
    paramFil   = '';
    seqFil     = '';
    seqDesc    = 'ep2d_perf';
    comm       = ['Bayesian analysis with LAIF model on Northwestern patient ' pid];
    lastRecFil = [path0 '/4dfp/ep2d_perf_xr3d.4dfp.img.rec'];

    img = 0;
    ifh = 0;
    try
      [img ifh] = fdf_to_4dfp('np755', pid, path, metric, lastRecFil, ...
          scals, lens, paramFil, seqFil, seqDesc, comm);
    catch ME
      error(['fdf_to_4dfd_wrapper.fdf_to_4dfp(....) failed for path ' path ', metric ' metric]);
    end


