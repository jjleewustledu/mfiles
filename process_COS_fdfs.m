%
% Usage:    [] = process_COS_fdfs()
%
%

function [] = process_COS_fdfs()

pids      = cellstr( ...
            ['vc1535'; 'vc1563'; 'vc4336'; 'vc4354'; 'vc4405'; ...
             'vc4420'; 'vc4426'; 'vc4437'; 'vc4497'; 'vc4500_bad_T1cbv_xr3d'; ...
             'vc4520'; 'vc4634'; 'vc4903'; 'vc5991'; 'vc5625_bad_T1cbv_xr3d'; ...
             'vc5647'; 'vc5821']);
slices    = [3 2 1 1 4 3 3 4 4 1 4 5 2 3 3 3 4];
params    = cellstr( ...
            ['Alpha   '; 'Beta    '; 'CBV     '; 'CBV_INT '; 'Delta   '; 'F       '; 'FracC   '; 'FracRec '; 'FracDrop'; 'Mtt     '; 'NoiseSd '; 'S0      '; 'S1      '; 'S2      '; 'T0      '; 'T02     ' ]);
metrics   = cellstr( ...
            ['mean'; 'peak'; 'var ']);
perfNames = cellstr( ...
            ['perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; ...
             'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusion_venous_xr3d'; 'perfusion_venous_xr3d'; 'perfusion_venous_xr3d'; ...
             'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; 'perfusionVenous_xr3d '; ...
             'perfusionVenous_xr3d '; 'perfusion_venous_xr3d']);

for ipid = 1:17
    pid   = char(pids(ipid));
    slice = slices(ipid);
    perfName = char(perfNames(ipid));

    for iparam = 1:16
        param = char(params(iparam));

        for imetric = 1:3
            metric = metrics(imetric);

            % disp(strcat(['fdf_wrapper ' pid ' ' num2str(slice) ' ' perfName ' ' param ' ' metric]));
            fdf_to_4dfp_wrapper('np287', pid, slice, perfName, param, metric);
            
        end
    end
    
    % disp(strcat(['fdf_wrapper ' pid ' ' num2str(slice) ' ' perfName ' ProbModel mean']));
    % disp(strcat(['fdf_wrapper ' pid ' ' num2str(slice) ' ' perfName ' ProbSignal mean']));
    fdf_to_4dfp_wrapper(pid, slice, perfName, 'ProbModel',  'mean');
    fdf_to_4dfp_wrapper(pid, slice, perfName, 'ProbSignal', 'mean');
    
end
