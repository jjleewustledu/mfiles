function estCbf = F_to_petCbf(Fval)

c0 = 1.06333; % y-intercept
c1 = 0.0596209; % slope

estCbf = (Fval - c0)./c1;
