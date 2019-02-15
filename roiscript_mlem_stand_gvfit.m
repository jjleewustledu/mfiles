frontal_grey = readcollection('t:\perfusion\masks\pt3\frontal_grey.msk','uint8',512,1024,1);
parietal_grey = readcollection('t:\perfusion\masks\pt3\parietal_grey.msk','uint8',512,1024,1);
occipital_grey = readcollection('t:\perfusion\masks\pt3\occipital_grey.msk','uint8',512,1024,1);
sylvian_grey = readcollection('t:\perfusion\masks\pt3\sylvian_grey.msk','uint8',512,1024,1);
thalamus = readcollection('t:\perfusion\masks\pt3\thalami.msk','uint8',512,1024,1);
putamen = readcollection('t:\perfusion\masks\pt3\putamen.msk','uint8',512,1024,1);
midbrain = readcollection('t:\perfusion\masks\pt3\midbrain.msk','uint8',512,1024,1);
head_caudate = readcollection('t:\perfusion\masks\pt3\head_caudate.msk','uint8',512,1024,1);
frontal_white = readcollection('t:\perfusion\masks\pt3\frontal_white.msk','uint8',512,1024,1);
parietal_white = readcollection('t:\perfusion\masks\pt3\parietal_white.msk','uint8',512,1024,1);
occipital_white = readcollection('t:\perfusion\masks\pt3\occipital_white.msk','uint8',512,1024,1);
genu = readcollection('t:\perfusion\masks\pt3\genu.msk','uint8',512,1024,1);
post_limb = readcollection('t:\perfusion\masks\pt3\post_limb.msk','uint8',512,1024,1);
callosum = readcollection('t:\perfusion\masks\pt3\callosum.msk','uint8',512,1024,1);
csf = readcollection('t:\perfusion\masks\pt3\csf.msk','uint8',512,1024,1);
lhs = readcollection('t:\perfusion\masks\pt3\lhs.msk','uint8',512,1024,1);
rhs = readcollection('t:\perfusion\masks\pt3\rhs.msk','uint8',512,1024,1);

rois = newim(1024, 512, 16);
rois(:,:,1) = frontal_grey(:,:,0);
rois(:,:,2) = parietal_grey(:,:,0);
rois(:,:,3) = occipital_grey(:,:,0);
rois(:,:,4) = sylvian_grey(:,:,0);
rois(:,:,5) = thalamus(:,:,0);
rois(:,:,6) = putamen(:,:,0);
rois(:,:,7) = midbrain(:,:,0);
rois(:,:,8) = head_caudate(:,:,0);
rois(:,:,9) = frontal_white(:,:,0);
rois(:,:,10) = parietal_white(:,:,0);
rois(:,:,11) = occipital_white(:,:,0);
rois(:,:,12) = genu(:,:,0);
rois(:,:,13) = post_limb(:,:,0);
rois(:,:,14) = callosum(:,:,0);
rois(:,:,15) = csf(:,:,0);

cbfgvfit = readcollection('t:\perfusion\asnr3\pt3\sSVD\standard\gvFitEverything\mle_cbf_net_x872_y382.dat','double',512,1024,1);
cbvgvfit = readcollection('t:\perfusion\asnr3\pt3\sSVD\standard\gvFitEverything\mle_cbv_net_x872_y382.dat','double',512,1024,1);
mttgvfit = readcollection('t:\perfusion\asnr3\pt3\sSVD\standard\gvFitEverything\mle_mtt_net_x872_y382.dat','double',512,1024,1);
cbfpet = readcollection('t:\perfusion\pet\pt3\rp_pt3_cbf_g5.dat','double',512,1024,1);
cbvpet = readcollection('t:\perfusion\pet\pt3\rp_pt3_cbv_g5.dat','double',512,1024,1);
mttpet = readcollection('t:\perfusion\pet\pt3\rp_pt3_mtt_g5.dat','double',512,1024,1);

study = newim(1024, 512, 7);
study(:,:,1) = scrubNaNs(cbfgvfit(:,:,0));
study(:,:,2) = scrubNaNs(cbvgvfit(:,:,0));
study(:,:,3) = scrubNaNs(mttgvfit(:,:,0));
study(:,:,4) = cbfpet(:,:,0);
study(:,:,5) = cbvpet(:,:,0);
study(:,:,6) = mttpet(:,:,0);

tmp = newim(1024, 512, 1);
excel_lhs_mymean = zeros(15, 6);
excel_lhs_mystd = zeros(15, 6);
excel_rhs_mymean = zeros(15, 6);
excel_rhs_mystd = zeros(15, 6);

for istudy = 1:6
    for irois = 1:15
            tmp = study(:,:,istudy)*lhs*rois(:,:,irois);
            mymean = sum(tmp)/sum(rois(:,:,irois));
            % use sigma^2 = <x^2> - <x>^2
            myvar = sum(tmp^2)/sum(rois(:,:,irois)) - mymean^2;
            mystd = sqrt(myvar);            
            excel_lhs_mymean(irois, istudy) = mymean;
            excel_lhs_mystd(irois, istudy) = mystd;
            excel_lhs(irois, istudy) = {[num2str(mymean) '  +/-  ' num2str(mystd)]}; 
    end
end

excel_lhs

for istudy = 1:6
    for irois = 1:15
            tmp = study(:,:,istudy)*rhs*rois(:,:,irois);
            mymean = sum(tmp)/sum(rois(:,:,irois));
            % use sigma^2 = <x^2> - <x>^2
            myvar = sum(tmp^2)/sum(rois(:,:,irois)) - mymean^2;
            mystd = sqrt(myvar);
            excel_rhs_mymean(irois, istudy) = mymean;
            excel_rhs_mystd(irois, istudy) = mystd;
            excel_rhs(irois, istudy) = {[num2str(mymean) '  +/-  ' num2str(mystd)]};   
    end
end

excel_rhs

petabscissas = zeros(30, 3);
petabscissas(1:15,1) = excel_lhs_mymean(:,4);
petabscissas(16:30,1) = excel_rhs_mymean(:,4);
petabscissas(1:15,2) = excel_lhs_mymean(:,5);
petabscissas(16:30,2) = excel_rhs_mymean(:,5);
petabscissas(1:15,3) = excel_lhs_mymean(:,6);
petabscissas(16:30,3) = excel_rhs_mymean(:,6);

mrordinates = zeros(30, 3);
mrordinates(1:15,1) = excel_lhs_mymean(:,1);
mrordinates(16:30,1) = excel_rhs_mymean(:,1);
mrordinates(1:15,2) = excel_lhs_mymean(:,2);
mrordinates(16:30,2) = excel_rhs_mymean(:,2);
mrordinates(1:15,3) = excel_lhs_mymean(:,3);
mrordinates(16:30,3) = excel_rhs_mymean(:,3);

legendLbls = { 'L FRONT GREY'; 'L PARIETAL GREY'; 'L OCC GREY'; 'L SYLVIAN GREY'; 'L THALAMUS'; 'L PUTAMEN'; 'L MIDBRAIN'; 'L CAUDATE'; 'L front white'; 'L parietal white'; 'L occ white'; 'L genu'; 'L post limb'; 'L callosum'; 'L csf'; 'R FRONT GREY'; 'R PARIETAL GREY'; 'R OCC GREY'; 'R SYLVIAN GREY'; 'R THALAMUS'; 'R PUTAMEN'; 'R MIDBRAIN'; 'R CAUDATE'; 'R front white'; 'R parietal white'; 'R occ white'; 'R genu'; 'R post limb'; 'R callosum'; 'R csf' };
colors = 'bbbbbbbbbbbbbbbrrrrrrrrrrrrrrr';
dingbats = '+x*osdph+x*^v><+x*osdph+x*^v><';
sizes = [20; 20; 20; 20; 20; 20; 20; 20; 10; 10; 10; 10; 10; 10; 10; 20; 20; 20; 20; 20; 20; 20; 20; 10; 10; 10; 10; 10; 10; 10 ];
gscatter(petabscissas(:,1), mrordinates(:,1), legendLbls, colors, dingbats, sizes)
%%%gscatter(petabscissas(:,2), mrordinates(:,2), legendLbls, colors, dingbats, sizes)
%%%gscatter(petabscissas(:,3), mrordinates(:,3), legendLbls, colors, dingbats, sizes)
