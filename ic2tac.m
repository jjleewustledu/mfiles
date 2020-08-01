function tac = ic2tac(ic)

ic = mlfourd.ImagingContext2(ic);
roi = mlfourd.ImagingContext2(fullfile(ic.filepath, 'wmparc_222.4dfp.hdr'));
roi = roi.binarized();
ic = ic.volumeAveraged(roi);
tac = ic.fourdfp.img;
figure
plot(tac)
xlabel('time frames')
ylabel('activity (Bq/mL)')


% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/ic2tac.m] ======  
