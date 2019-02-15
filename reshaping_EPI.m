a = zeros(256, 256, 18, 71);
a = read4d('~/petsun55/jjlee/ImageCoreg/pt3/EPI_on_prebolus3.4dfp.img', 'ieee-be', 'single', 256, 256, 32, 71, 7, 18, 0);
b = zeros(256*256*18,71, 1, 1);
b = reshape(a, 256*256*18, 71, 1, 1);
write4d(b, 'single', 'ieee-le', '~/petsun55/jjlee/epi_1179648_71_1_1.ieee-le.4dfp.img');
b = double(squeeze(b));