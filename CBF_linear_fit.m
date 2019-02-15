% perform linear fit on CBF data
% get data
fid = fopen('CBFvals.txt','r');
N = 77;

pet_cbf = zeros(N,1);
laif_cbf = zeros(N,1);
mlem_cbf = zeros(N,1);
norm_cbf = zeros(N,1);

for i=1:N
    C = fscanf(fid, '%f %f %f %f\n');
    pet_cbf(i) = C(1);
    laif_cbf(i) = C(2);
    mlem_cbf(i) = C(3);
    norm_cbf(i) = C(4);
end
fclose(fid);

% get averages
avg_pet = mean(pet_cbf);
avg_laif = mean(laif_cbf);
avg_mlem = mean(mlem_cbf);
avg_norm = mean(norm_cbf);

%fprintf('avgs: %f %f %f %f\n',avg_pet, avg_laif, avg_mlem, avg_norm);

% calc for PearsonR
spet = sum((pet_cbf - avg_pet).^2);
slaif = sum((laif_cbf - avg_laif).^2);
smlem = sum((mlem_cbf - avg_mlem).^2);
snorm = sum((norm_cbf - avg_norm).^2);
spetlaif = sum((pet_cbf - avg_pet).*(laif_cbf - avg_laif));
spetmlem = sum((pet_cbf - avg_pet).*(mlem_cbf - avg_mlem));
spetnorm = sum((pet_cbf - avg_pet).*(norm_cbf - avg_norm));

x = 0:80;

% fitting section curve 1,
[p1, S] = polyfit(pet_cbf, laif_cbf, 1);
Rinv = eye(2)/S.R;
Emat = (Rinv*Rinv')*S.normr^2/S.df;

r1 = spetlaif/sqrt(spet*slaif);

fprintf('\ncurve 1: pet vs. laif, Pearson: %f\n',r1);
fprintf('slope %f +/- %f\n',p1(1),sqrt(Emat(1,1)));
fprintf('intercept %f +/- %f\n',p1(2),sqrt(Emat(2,2)));


% plot both curves 
f1 = polyval(p1,x);
figure(1);
hold on;
title('PET vs LAIF');
plot(pet_cbf, laif_cbf, 'x', x,f1,'-');
axis([0 8 0 80]);
hold off;


% fitting section curve 2
[p, S] = polyfit(mlem_cbf, pet_cbf, 1);
Rinv = eye(2)/S.R;
Emat = (Rinv*Rinv')*S.normr^2/S.df;

r2 = spetmlem/sqrt(spet*smlem);

fprintf('\ncurve 2: mlem vs pet, Pearson: %f\n',r2);
fprintf('slope %f +/- %f\n',p(1),sqrt(Emat(1,1)));
fprintf('intercept %f +/- %f\n',p(2),sqrt(Emat(2,2)));

f = polyval(p,x);
figure(2);
hold on;
title('MLEM vs PET');
plot(mlem_cbf, pet_cbf, 'x', x,f,'-');
axis([0 3 0 80]);
hold off;

% fitting section curve 3
[p, S] = polyfit(norm_cbf, pet_cbf, 1);
Rinv = eye(2)/S.R;
Emat = (Rinv*Rinv')*S.normr^2/S.df;

r3 = spetnorm/sqrt(spet*snorm);

fprintf('\ncurve 3: norm vs pet, Pearson: %f\n',r3);
fprintf('slope %f +/- %f\n',p(1),sqrt(Emat(1,1)));
fprintf('intercept %f +/- %f\n',p(2),sqrt(Emat(2,2)));

f = polyval(p,x);
figure(3);
hold on;
title('NORM MLEM vs PET');
plot(norm_cbf, pet_cbf, 'x', x,f,'-');
axis([0 80 0 80]);
hold off;

