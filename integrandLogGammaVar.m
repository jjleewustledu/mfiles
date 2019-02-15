function y = integrandLogGammaVar(t)
alpha = 7.6;
beta = 1.26;
lambda = 1;
y = exp(-lambda*t) .* (alpha*log(t) - beta*t)
