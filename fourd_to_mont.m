function outmont = fourd_to_mont(in4d)

N = 256;
outmont = newim(4*N,2*N);

outmont(3*N:(4*N-1), N:(2*N-1)) = in4d(:,:,0,0);
outmont(2*N:(3*N-1), N:(2*N-1)) = in4d(:,:,1,0);
outmont(N:(2*N-1),  N:(2*N-1)) = in4d(:,:,2,0);
outmont(0:(N-1),   N:(2*N-1)) = in4d(:,:,3,0);
outmont(3*N:(4*N-1), 0:(N-1))  = in4d(:,:,4,0);
outmont(2*N:(3*N-1), 0:(N-1))  = in4d(:,:,5,0);
outmont(N:(2*N-1),  0:(N-1))  = in4d(:,:,6,0);
outmont(0:(N-1),   0:(N-1))  = in4d(:,:,7,0);