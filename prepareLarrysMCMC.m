function prepareLarrysMCMC(a)




BASE = 'hbo_070924_ep2dpx';

path4dfp = '/mnt/hgfs/perfusion/HyperbaricO2/hbo_070924/';
if (nargin < 1)
    a = read4d([path4dfp BASE '.4dfp.img'], ...
        'ieee-be', 'float', 128, 128, 9, 179, 0, 0, 0); 
end

a0 = a(:,:,0,:);
a1 = a(:,:,1,:);
a2 = a(:,:,2,:);
a3 = a(:,:,3,:);
a4 = a(:,:,4,:);
a5 = a(:,:,5,:);
a6 = a(:,:,6,:);
a7 = a(:,:,7,:);
a8 = a(:,:,8,:);

write4d(a0, 'float', 'ieee-be', [path4dfp BASE '_slice0.4dfp.img']);
write4d(a1, 'float', 'ieee-be', [path4dfp BASE '_slice1.4dfp.img']);
write4d(a2, 'float', 'ieee-be', [path4dfp BASE '_slice2.4dfp.img']);
write4d(a3, 'float', 'ieee-be', [path4dfp BASE '_slice3.4dfp.img']);
write4d(a4, 'float', 'ieee-be', [path4dfp BASE '_slice4.4dfp.img']);
write4d(a5, 'float', 'ieee-be', [path4dfp BASE '_slice5.4dfp.img']);
write4d(a6, 'float', 'ieee-be', [path4dfp BASE '_slice6.4dfp.img']);
write4d(a7, 'float', 'ieee-be', [path4dfp BASE '_slice7.4dfp.img']);
write4d(a8, 'float', 'ieee-be', [path4dfp BASE '_slice8.4dfp.img']);
