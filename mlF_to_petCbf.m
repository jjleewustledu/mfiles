function estCbf = mlF_to_petCbf(mlemVal)

c0 = 0.110849; % y-intercept
c1 = 0.0161516; % slope

estCbf = (mlemVal - c0)./c1;
