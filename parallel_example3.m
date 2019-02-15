function [kmps,tf] = parallel_example3

t0 = tic %#ok<*NOPRT>

subjectPth = fullfile('/home/jjlee', 'Arbelaez', 'GluT', 'p8039_JJL', '');
cd(subjectPth);
[ks,kmps] = Kinetics4McmcProblem.run(subjectPth, 2); %#ok<ASGLU>
            
tf = toc(t0)

save('parallel_example3.mat');

end