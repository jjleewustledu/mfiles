%
% Usage:    process_COS_fdfs2()
%
%

function [] = process_COS_fdfs2()

    pids      = cellstr( ...
                ['vc1535'; 'vc1563'; 'vc4336'; 'vc4354'; 'vc4405'; ...
                 'vc4420'; 'vc4426'; 'vc4437'; 'vc4497'; 'vc4500'; ...
                 'vc4520'; 'vc4634'; 'vc4903'; 'vc5991'; 'vc5625'; ...
                 'vc5647'; 'vc5821']);
    slices    = [3 2 1 1 4 3 3 4 4 1 4 5 2 3 3 3 4];
    params    = cellstr( ...
                ['Alpha    '; 'Beta     '; 'CBV      '; 'CBV_INT  '; 'Delta    '; ...
                 'F        '; 'FracC    '; 'FracRec  '; 'FractDrop'; 'Mtt      '; ...
                 'NoiseSd  '; 'S0       '; 'S1       '; 'S2       '; 'T0       '; 'T02      ' ]);
    metrics   = cellstr( ...
                ['mean'; 'peak'; 'var ']);
    perfNames = cellstr( ...
                ['perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; ...
                 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusion_venous_xr3d'; 'perfusion_venous_xr3d'; 'perfusion_venous_xr3d'; ...
                 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; ...
                 'perfusionVenous_xr3d '; 'perfusion_venous_xr3d']);

    for ipid = 1:17
        pid   = char(pids(ipid));
        if (10 == ipid | 15 == ipid)
          pid = [pid '_bad_T1cbv_xr3d'];
        end
        slice = slices(ipid);
        perfName = char(perfNames(ipid));

        for iparam = 1:16
            param = char(params(iparam));
            disp(['param -> ' param]);
            for imetric = 1:3
                metric = char(metrics(imetric));

                disp(['calling fdf_to_4dfp_wrapper(' pid ', ' num2str(slice) ', ' perfName ', ' param metric]);
                try
                  COS_fdf_wrapper('np287', pid, slice, perfName, param, metric);
                catch
                  disp(['failed to execute fdf_to_4dfp_wrapper(' pid ', ' num2str(slice) ', ' perfName ', ' param metric]);
                end

            end
        end

        % disp(['fdf_wrapper ' pid ' ' num2str(slice) ' ' perfName ' ProbModel mean']);
        % disp(['fdf_wrapper ' pid ' ' num2str(slice) ' ' perfName ' ProbSignal mean']);
        % fdf_to_4dfp_wrapper(pid, slice, perfName, 'ProbModel',  'mean');
        % fdf_to_4dfp_wrapper(pid, slice, perfName, 'ProbSignal', 'mean');

    end
