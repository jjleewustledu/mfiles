function t = parallel_example(iter)

if nargin == 0, iter = 16; end
disp('Start sim')

t0 = tic;
parfor idx = 1:iter
    A{idx} = idx;
    pause(2)
end
t = toc(t0);

save(sprintf('parallel_example_%s.mat',datestr(now, 30)), 'A');

disp('Sim completed.')
