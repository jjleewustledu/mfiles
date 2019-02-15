%LOOKLOCKERMAGN
%
% Usage:  Marray = looklockerMagn()
%
% M(n) are longitudinal magnetizations
% X $\equals$ fraction of saturation
% 

function [M MnMinfty logMnMinfty Mobs MobsCH] = looklockerMagn(theta)

% for a single voxel

N = 120; % number of pulses
M = zeros(N, 1);
MnMinfty = zeros(N, 1);
logMnMinfty = zeros(N, 1);
Mobs = zeros(N, 1);
MobsCH = zeros(N, 1);

Meq = 1;
M0  = 1;
tau = 2; % fixed value in IRLLEPI; Shin MRM (2006) 56 138-45
T1  = 1;

X = 1 - cos(theta); % flip angle theta, 0 < theta < pi
y = (1 - X);  % therefor, y = cos(theta);
u = exp(-tau/T1);

for n = 1:N
	M(n) = Meq*(1 - u)*(1 - y^n*u^n)/(1 - y*u) + M0*y^n*u^n;
end

Minfty = Meq*(1 - u)/(1 - y*u);

for n = 1:N
	MnMinfty(n) = (M0 - Minfty)*((1 - X)*exp(-tau/T1))^n; % $\leftarrow$ M(n) - Minfty 
end
for n = 1:N
	logMnMinfty(n) = log(M0 - Minfty) + n*log(exp(-tau/T1)*(1 + (Meq - Minfty)/Minfty) - (Meq - Minfty)/Minfty);
end

Mobs(n) = M(n)*sin(theta);

paren = 0;
for n = 1:N
	paren = y*(1 - (u*y)^(n-1))/(1 + y*(u*y)^(n-1)) + 1;
	MobsCH(n) = -(1 - u)*paren*sin(theta)/(1 - u*y);
end
