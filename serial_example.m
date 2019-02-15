function t = serial_example(iter)

if nargin == 0, iter = 16; end
disp('Start sim')

t0 = tic;
for idx = 1:iter
    A{idx} = idx;
    pause(2)
end
t = toc(t0);

save(sprintf('serial_example_%s.mat',datestr(now, 30)), 'A');

disp('Sim completed.')
