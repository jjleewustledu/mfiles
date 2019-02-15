function out4d = mont_to_4d(inmont)

inmont = squeeze(inmont);
N = 256;
out4d = newim(N,N,8,1);

out4d(:,:,0,0) = inmont(3N:(4N-1), N:(2N-1));
out4d(:,:,1,0) = inmont(2N:(3N-1), N:(2N-1));
out4d(:,:,2,0) = inmont(N:(2N-1),  N:(2N-1));
out4d(:,:,3,0) = inmont(0:(N-1),   N:(2N-1));
out4d(:,:,4,0) = inmont(3N:(4N-1), 0:(N-1));
out4d(:,:,5,0) = inmont(2N:(3N-1), 0:(N-1));
out4d(:,:,6,0) = inmont(N:(2N-1),  0:(N-1));
out4d(:,:,7,0) = inmont(0:(N-1),   0:(N-1));