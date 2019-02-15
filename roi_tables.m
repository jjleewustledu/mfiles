sum(all)
all = butCbf > eps & extra_tag;
sum(all)
info = peekInfo('allrois', 'ho1', 'both', 1, 0)
greys  = all & strcmp(info(:,3), 'grey');
basals = all & strcmp(info(:,3), 'basal');
whites = all & strcmp(info(:,3), 'white');
sum(greys) + sum(basals) + sum(whites)
ipsis = all & strcmp(info(:,4), 'ipsi');
contras = all & strcmp(info(:,4,), 'contra'):
contras = all & strcmp(info(:,4), 'contra'):
contras = all & strcmp(info(:,4), 'contra.'):
ipsis = all & strcmp(info(:,4), 'contra');
ipsis = all & strcmp(info(:,4), 'ipsi.');
contras = all & strcmp(info(:,4), 'contra.');
sum(ipsis) + sum(contras)
butCbf_grey = compactArray(butCbf, greys);
size(butCbf_grey)
butCbf_basals = compactArray(butCbf, basals);
butCbf_whites = compactArray(butCbf, whites);
butCbf_white = compactArray(butCbf, whites);
butCbf_basal = compactArray(butCbf, basals);
butCbf_ipsi = compactArray(butCbf, ipsis);
butCbf_contra = compactArray(butCbf, contras);
size(laifF)
laifCbf = convertF(laifF, 'laifF', 'butCbf', cfit, butCbf, extra_tag, '/home/jjlee/2007dec13.mat')
cfit
laifCbf = convertF(laifF, 'laifF', 'butCbf', cfit.cfun, butCbf, extra_tag, '/home/jjlee/2007dec13.mat')
mlemCbf = convertF(mlemF, 'mlemF', 'butCbf', cfit2.cfun, butCbf, extra_tag, '/home/jjlee/2007dec13.mat')
mlemCbf = convertF(mlemF, 'mlemF', 'butCbf')
size(mlemCbf)
laifCbf = convertF(laifF, 'laifF', 'butCbf')
laifCbf = convertF2(laifF, 'laifF', 'butCbf')
mlemCbf = convertF2(mlemF, 'mlemF', 'butCbf')
size(mlemCbf)
size(laifCbf)
mlemRefCbf_grey = compactArray(mlemRefCbf, greys);
mlemRefCbf_basal = compactArray(mlemRefCbf, basals);
mlemRefCbf_white = compactArray(mlemRefCbf, whites);
mlemRefCbf_ipsi = compactArray(mlemRefCbf, ipsis);
mlemRefCbf_contra = compactArray(mlemRefCbf, contras);
mlemCbf_grey = compactArray(mlemCbf, greys);
mlemCbf_basal = compactArray(mlemCbf, basals);
mlemCbf_white = compactArray(mlemCbf, whites);
mlemCbf_ipsi = compactArray(mlemCbf, ipsis);
mlemCbf_contra = compactArray(mlemCbf, contras);
laifCbf_grey = compactArray(laifCbf, greys);
laifCbf_basal = compactArray(laifCbf, basals);
laifCbf_white = compactArray(laifCbf, whites);
laifCbf_ipsi = compactArray(laifCbf, ipsis);
laifCbf_contra = compactArray(laifCbf, contras);
