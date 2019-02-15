function [names,t1] = parallel_example2(iter)

t0 = tic %#ok<*NOPRT>
parfor idx = 1:iter
	[~,names{idx}] = mlbash('hostname');
end
t1 = toc(t0)

end