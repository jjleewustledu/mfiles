function cbf = mlemF_to_CBF(F)

c0 = 0.1103; % intercept
c1 = 0.01616; % slope

cbf = (F - c0) / c1;
