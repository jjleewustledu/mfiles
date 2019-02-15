function estCbf = mlRefCbf_to_petCbf(mlemVal)

c0 = -1.71777; % y-intercept
c1 = 1.04844; % slope

estCbf = (mlemVal - c0)./c1;
