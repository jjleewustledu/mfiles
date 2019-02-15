function cbf = laifF_to_CBF(F)

c0 = 1.07; % intercept
c1 = 0.05948; % slope

cbf = (F - c0) / c1;
