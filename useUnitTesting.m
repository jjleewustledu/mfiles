function [loader runner] = useUnitTesting(plat, verb)

%% USEUNITTESTING
%  Usage:  [loader runner] = useUnitTesting(plat, verb)
%                                           ^ xunit, mlunit2
%                                                 ^ verbosity:  0,1,2
%
if (nargin < 2); verb = 2; end
srcroot = fullfile(getenv('HOME'), 'MATLAB-Drive', '');
loader = 0; runner = 0;
switch (plat)
    case {'xunit', 'matlab_xunit'}
        addpath([srcroot, '/matlab_xunit/xunit']); %#ok<*MCAP>
        rmpath( [srcroot, '/mlunit2/src']);
        rmpath( [srcroot, '/mlunit2/src']);
    case {'mlunit', 'mlunit2'}
        rmpath([ srcroot, '/matlab_xunit/xunit']);
        addpath([srcroot, '/mlunit2/src']);
        addpath([srcroot, '/mlunit2/src']);
        runner = mlunit.text_test_runner(1, verb);
        loader = mlunit.test_loader;
    otherwise
        error('mfiles:ParamValueNotSupported', ['useUnitTesting does not support plat -> ' plat]);
end
end
