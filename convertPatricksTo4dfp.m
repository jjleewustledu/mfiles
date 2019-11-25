function product = convertPatricksTo4dfp(fn)

addpath('~jjlee/matlab')
reg = MatlabRegistry.instance();

%% if path error, comment out the two nonempty lines above and uncomment line below 
%addpath(genpath('~jjlee/MATLAB-Drive'))

product = mlperceptron.PerceptronFromMat.convertPatricksTo4dfp(fn)
