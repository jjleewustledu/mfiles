
Nx = 1024;
Ny = 512;
Npts = 1
Npetstudies = 3
Nstudies = 2;
petdir = 't:\perfusion\pet\'
maskdir = 't:\perfusion\masks\'
studydir = 't:\perfusion\asnr3\'
studydir2 = 't:\perfusion\asnr2\'
ipt = 3

TINY = 1.0e-15;
    
% ------------------------------------------------ Set-up Masks ------------------------------------------------

grey            = newim(Nx, Ny);
white           = newim(Nx, Ny);
front           = newim(Nx, Ny);
front_grey      = newim(Nx, Ny);
front_white     = newim(Nx, Ny);
parietal        = newim(Nx, Ny);
parietal_grey   = newim(Nx, Ny);
parietal_white  = newim(Nx, Ny);
occiput         = newim(Nx, Ny);
occiput_grey    = newim(Nx, Ny);
occiput_white   = newim(Nx, Ny);
sylvian         = newim(Nx, Ny);
sylvian_grey    = newim(Nx, Ny);
sylvian_white   = newim(Nx, Ny);
thalamus        = newim(Nx, Ny);
putamen         = newim(Nx, Ny);
midbrain        = newim(Nx, Ny);
head_caudate    = newim(Nx, Ny);
genu            = newim(Nx, Ny);
post_limb       = newim(Nx, Ny);
callosum        = newim(Nx, Ny);
csf             = newim(Nx, Ny);
lhs             = newim(Nx, Ny);
rhs             = newim(Nx, Ny);

grey(:,:)           = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\grey.msk'],     'uint8',Ny,Nx,1));
white(:,:)          = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\white.msk'],    'uint8',Ny,Nx,1));
front(:,:)          = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\front.msk'],    'uint8',Ny,Nx,1));
parietal(:,:)       = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\parietal.msk'], 'uint8',Ny,Nx,1));
occiput(:,:)        = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\occiput.msk'],  'uint8',Ny,Nx,1));
sylvian(:,:)        = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\sylvian.msk'],  'uint8',Ny,Nx,1));
front_grey(:,:)     = grey (:,:) & front   (:,:);
front_white(:,:)    = white(:,:) & front   (:,:);
parietal_grey(:,:)  = grey (:,:) & parietal(:,:);
parietal_white(:,:) = white(:,:) & parietal(:,:);
occiput_grey(:,:)   = grey (:,:) & occiput (:,:);
occiput_white(:,:)  = white(:,:) & occiput (:,:);
sylvian_grey(:,:)   = grey (:,:) & sylvian (:,:);
sylvian_white(:,:)  = white(:,:) & sylvian (:,:);
thalamus(:,:)       = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\thalamus.msk'],    'uint8',Ny,Nx,1));
putamen(:,:)        = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\putamen.msk'],     'uint8',Ny,Nx,1));
midbrain(:,:)       = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\midbrain.msk'],    'uint8',Ny,Nx,1));
head_caudate(:,:)   = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\head_caudate.msk'],'uint8',Ny,Nx,1));
genu(:,:)           = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\genu.msk'],        'uint8',Ny,Nx,1));
post_limb(:,:)      = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\post_limb.msk'],   'uint8',Ny,Nx,1));
callosum(:,:)       = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\callosum.msk'],    'uint8',Ny,Nx,1));
csf(:,:)            = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\csf.msk'],         'uint8',Ny,Nx,1));
lhs(:,:)            = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\lhs.msk'],         'uint8',Ny,Nx,1));
rhs(:,:)            = squeeze(readcollection([maskdir 'pt' num2str(ipt) '\rhs.msk'],         'uint8',Ny,Nx,1));

% ----------------------------------------------- Set-up Indexed ROIs ---------------------------------------------

Nrois = 14;
rois = newim(Nx, Ny, Nrois + 1);
rois(:,:,1)  = reshape(front(:,:)      & grey(:,:), Nx, Ny, 1);
rois(:,:,2)  = reshape(parietal(:,:)   & grey(:,:), Nx, Ny, 1);
rois(:,:,3)  = reshape(occiput(:,:)    & grey(:,:), Nx, Ny, 1);
rois(:,:,4)  = reshape(sylvian(:,:)    & grey(:,:), Nx, Ny, 1);
rois(:,:,5)  = reshape(thalamus(:,:),               Nx, Ny, 1);
rois(:,:,6)  = reshape(putamen(:,:),                Nx, Ny, 1);
rois(:,:,7)  = reshape(head_caudate(:,:),           Nx, Ny, 1);
rois(:,:,8)  = reshape(front(:,:)     & white(:,:), Nx, Ny, 1);
rois(:,:,9) = reshape(parietal(:,:)  & white(:,:), Nx, Ny, 1);
rois(:,:,10) = reshape(occiput(:,:)   & white(:,:), Nx, Ny, 1);
rois(:,:,11) = reshape(genu(:,:),                   Nx, Ny, 1);
rois(:,:,12) = reshape(post_limb(:,:),              Nx, Ny, 1);
rois(:,:,13) = reshape(callosum(:,:),               Nx, Ny, 1);
rois(:,:,14)  = reshape(csf(:,:),                   Nx, Ny, 1);
% rois(:,:,7)  = reshape(midbrain(:,:),               Nx, Ny, 1);

% -------------------------------------------- Set-up Indexed MR Studies -------------------------------------------

petstudy = newim(Nx, Ny, Npetstudies + 1);
petstudy(:,:,1) = readcollection([petdir 'pt' num2str(ipt) '\rp_pt' num2str(ipt) '_cbf_g5.dat'],'double',Ny,Nx,1);
petstudy(:,:,2) = readcollection([petdir 'pt' num2str(ipt) '\rp_pt' num2str(ipt) '_cbv_g5.dat'],'double',Ny,Nx,1);
petstudy(:,:,3) = readcollection([petdir 'pt' num2str(ipt) '\rp_pt' num2str(ipt) '_mtt_g5.dat'],'double',Ny,Nx,1);

% manual check
%%%petstudy

study = newim(Nx, Ny, Nstudies + 1);
study(:,:,1) = scrubNaNs(readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_cbf_net_x916_y384.dat'],'double',Ny,Nx,1));
study(:,:,2) = scrubNaNs(readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_cbf_net_x916_y384.dat'],'double',Ny,Nx,1));

% study(:,:,1) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_cbf_net_x947_y369.dat'],'double',Ny,Nx,1);
% study(:,:,2) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_cbf_net_x947_y369.dat'],'double',Ny,Nx,1);
% study(:,:,3) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_cbf_net_x856_y382.dat'],'double',Ny,Nx,1);
% study(:,:,4) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_cbf_net_x856_y382.dat'],'double',Ny,Nx,1);

% study(:,:,5) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_cbv_net_x947_y369.dat'],'double',Ny,Nx,1);
% study(:,:,6) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_cbv_net_x947_y369.dat'],'double',Ny,Nx,1);
% study(:,:,7) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_cbv_net_x856_y382.dat'],'double',Ny,Nx,1);
% study(:,:,8) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_cbv_net_x856_y382.dat'],'double',Ny,Nx,1);

% study(:,:,9) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_mtt_net_x947_y369.dat'],'double',Ny,Nx,1);
% study(:,:,10) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_mtt_net_x947_y369.dat'],'double',Ny,Nx,1);
% study(:,:,11) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_mtt_net_x856_y382.dat'],'double',Ny,Nx,1);
% study(:,:,12) = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_mtt_net_x856_y382.dat'],'double',Ny,Nx,1);

% study(:,:,1)  = readcollection(['pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_cbf_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,2)  = readcollection(['pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_cbv_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,3)  = readcollection(['pt' num2str(ipt) '\MLEM_LOG_QUADRATIC_mtt_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,4)  = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_cbf_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,5)  = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_cbv_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,6)  = readcollection([studydir 'pt' num2str(ipt) '\MLEM_LOG_LINEAR_mtt_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,7)  = readcollection([studydir 'pt' num2str(ipt) '\SSVD_LOG_LINEAR_gvfitall_cbf_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,7)  = readcollection([studydir 'pt' num2str(ipt) '\SSVD_LOG_LINEAR_gvfitall_cbv_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,8)  = readcollection([studydir 'pt' num2str(ipt) '\SSVD_LOG_LINEAR_gvfitall_mtt_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,9)  = readcollection([studydir 'pt' num2str(ipt) '\SSVD_LOG_LINEAR_cbf_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,11) = readcollection([studydir 'pt' num2str(ipt) '\SSVD_LOG_LINEAR_cbv_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,12) = readcollection([studydir 'pt' num2str(ipt) '\SSVD_LOG_LINEAR_mtt_net_x617_y428.dat'],'double',Ny,Nx,1);
% study(:,:,13) = readcollection([studydir2 'pt' num2str(ipt) '\osvd_cbf_0.dat'],'double',Ny,Nx,1);
% study(:,:,14) = readcollection([studydir2 'pt' num2str(ipt) '\osvd_cbv_0.dat'],'double',Ny,Nx,1);
% study(:,:,15) = readcollection([studydir2 'pt' num2str(ipt) '\osvd_mtt_0.dat'],'double',Ny,Nx,1);
% study(:,:,16) = readcollection([studydir2 'pt' num2str(ipt) '\fft_cbf_0.dat'],'double',Ny,Nx,1);
% study(:,:,17) = readcollection([studydir2 'pt' num2str(ipt) '\fft_cbv_0.dat'],'double',Ny,Nx,1);
% study(:,:,18) = readcollection([studydir2 'pt' num2str(ipt) '\fft_mtt_0.dat'],'double',Ny,Nx,1);
% study(:,:,19) = readcollection([studydir 'pt' num2str(ipt) '\ttp_net.dat'],'double',Ny,Nx,1);
% study(:,:,20) = readcollection([studydir 'pt' num2str(ipt) '\rph_net.dat'],'double',Ny,Nx,1);

% manual check
%%%study

tmp = newim(Nx, Ny, 1);
mr_lhs_mymean = zeros(Nrois, Nstudies);
mr_lhs_mystd = zeros(Nrois, Nstudies);
mr_rhs_mymean = zeros(Nrois, Nstudies);
mr_rhs_mystd = zeros(Nrois, Nstudies);
pet_lhs_mymean = zeros(Nrois, Npetstudies);
pet_lhs_mystd = zeros(Nrois, Npetstudies);
pet_rhs_mymean = zeros(Nrois, Npetstudies);
pet_rhs_mystd = zeros(Nrois, Npetstudies);
roisCorr = newim(Nx, Ny);

% Implementing corrected two-pass calculation of the variance,
% per Num. Rec. in C++, 2nd ed., sec. 14.1, pg. 618.  See also routine NR::moment.

for istudy = 1:Nstudies
    for irois = 1:Nrois
        roisCorr = squeeze(rois(:,:,irois));
        for x = 0:Nx-1
            for y = 0:Ny-1
                if (study(x,y,istudy) < TINY)
                    roisCorr(x,y) = 0;
                end
            end
        end
        Nroipixels = sum(roisCorr(:,:));
        if (Nroipixels < 2) 
            Nroipixels = 2;
        end
        data_img = study(:,:,istudy)*lhs*roisCorr(:,:);
        ave = sum(data_img)/Nroipixels;
        adev = sum(abs(data_img - ave))/Nroipixels;
        ep = sum(data_img - ave);
        firstpass = sum((data_img - ave)*(data_img - ave));
        var = (firstpass - ep^2/Nroipixels)/(Nroipixels - 1);
        sdev = sqrt(var);            
        mr_lhs_mymean(irois, istudy) = ave;
        mr_lhs_mystd(irois, istudy) = sdev;
    end
end
for istudy = 1:Nstudies
    for irois = 1:Nrois
        roisCorr = squeeze(rois(:,:,irois));
        for x = 0:Nx-1
            for y = 0:Ny-1
                if (study(x,y,istudy) < TINY)
                    roisCorr(x,y) = 0;
                end
            end
        end
        Nroipixels = sum(roisCorr(:,:));
        if (Nroipixels < 2) 
            Nroipixels = 2;
        end
        data_img = study(:,:,istudy)*rhs*roisCorr(:,:);
        ave = sum(data_img)/Nroipixels;
        adev = sum(abs(data_img - ave))/Nroipixels;
        ep = sum(data_img - ave);
        firstpass = sum((data_img - ave)*(data_img - ave));
        var = (firstpass - ep^2/Nroipixels)/(Nroipixels - 1);
        sdev = sqrt(var);            
        mr_rhs_mymean(irois, istudy) = ave;
        mr_rhs_mystd(irois, istudy) = sdev;
    end
end

for i = 1:Npetstudies
	for irois = 1:Nrois
        roisCorr = squeeze(rois(:,:,irois));
        for x = 0:Nx-1
            for y = 0:Ny-1
                if (study(x,y,istudy) < TINY)
                    roisCorr(x,y) = 0;
                end
            end
        end
        Nroipixels = sum(roisCorr(:,:));
        if (Nroipixels < 2)
            Nroipixels = 2;
        end
        data_img = petstudy(:,:,i)*lhs*roisCorr(:,:);
        ave = sum(data_img)/Nroipixels;
        adev = sum(abs(data_img - ave))/Nroipixels;
        ep = sum(data_img - ave);
        firstpass = sum((data_img - ave)*(data_img - ave));
		var = (firstpass - ep^2/Nroipixels)/(Nroipixels - 1);
		sdev = sqrt(var);            
		pet_lhs_mymean(irois, i) = ave;
		pet_lhs_mystd(irois, i) = sdev;
	end
end
for i = 1:Npetstudies
	for irois = 1:Nrois
        roisCorr = squeeze(rois(:,:,irois));
        for x = 0:Nx-1
            for y = 0:Ny-1
                if (study(x,y,istudy) < TINY)
                    roisCorr(x,y) = 0;
                end
            end
        end
        Nroipixels = sum(roisCorr(:,:));
        if (Nroipixels < 2)
            Nroipixels = 2;
        end
        data_img = petstudy(:,:,i)*rhs*roisCorr(:,:);
        ave = sum(data_img)/Nroipixels;
        adev = sum(abs(data_img - ave))/Nroipixels;
        ep = sum(data_img - ave);
        firstpass = sum((data_img - ave)*(data_img - ave));
		var = (firstpass - ep^2/Nroipixels)/(Nroipixels - 1);
		sdev = sqrt(var);            
		pet_rhs_mymean(irois, i) = ave;
		pet_rhs_mystd(irois, i) = sdev;
	end
end

mrordinates = zeros(2*Nrois, Nstudies);
for istudies = 1:Nstudies
	mrordinates(1:Nrois,istudies) = mr_lhs_mymean(:,istudies);
	mrordinates(Nrois+1:2*Nrois,istudies) = mr_rhs_mymean(:,istudies);
end

petabscissas = zeros(2*Nrois, Npetstudies);
for i = 1:Npetstudies
	petabscissas(1:Nrois,i) = pet_lhs_mymean(:,i);
	petabscissas(Nrois+1:2*Nrois,i) = pet_rhs_mymean(:,i);
end

% legendLbls = { 'L FRONT GREY'; 'L PARIETAL GREY'; 'L OCC GREY'; 'L SYLVIAN GREY'; 'L THALAMUS'; 'L PUTAMEN'; 'L MIDBRAIN'; 'L CAUDATE'; 'L front white'; 'L parietal white'; 'L occ white'; 'L genu'; 'L post limb'; 'L callosum'; 'L csf'; 'R FRONT GREY'; 'R PARIETAL GREY'; 'R OCC GREY'; 'R SYLVIAN GREY'; 'R THALAMUS'; 'R PUTAMEN'; 'R MIDBRAIN'; 'R CAUDATE'; 'R front white'; 'R parietal white'; 'R occ white'; 'R genu'; 'R post limb'; 'R callosum'; 'R csf' };
% colors = 'bbbbbbbbbbbbbbymmmmmmmmmmmmmmy';
% dingbats = '+x*osdph+x*^v>++x*osdph+x*^v>+';
% sizes = [30; 30; 30; 30; 30; 30; 30; 30; 10; 10; 10; 10; 10; 10; 60; 30; 30; 30; 30; 30; 30; 30; 30; 10; 10; 10; 10; 10; 10; 60 ];
legendLbls = { 'L FRONT GREY'; 'L PARIETAL GREY'; 'L OCC GREY'; 'L SYLVIAN GREY'; 'L THALAMUS'; 'L PUTAMEN'; 'L CAUDATE'; 'L front white'; 'L parietal white'; 'L occ white'; 'L genu'; 'L post limb'; 'L callosum'; 'L csf'; 'R FRONT GREY'; 'R PARIETAL GREY'; 'R OCC GREY'; 'R SYLVIAN GREY'; 'R THALAMUS'; 'R PUTAMEN'; 'R CAUDATE'; 'R front white'; 'R parietal white'; 'R occ white'; 'R genu'; 'R post limb'; 'R callosum'; 'R csf' };
colors = 'bbbbbbbbbbbbbymmmmmmmmmmmmmy';
dingbats = '+x*osdh+x*^v>++x*osdh+x*^v>+';
sizes = [30; 30; 30; 30; 30; 30; 30; 10; 10; 10; 10; 10; 10; 60; 30; 30; 30; 30; 30; 30; 30; 10; 10; 10; 10; 10; 10; 60 ];
%%%gscatter(petabscissas(:,1), mrordinates(:,1), legendLbls, colors, dingbats, sizes)
%%%gscatter(petabscissas(:,2), mrordinates(:,2), legendLbls, colors, dingbats, sizes)
%%%gscatter(petabscissas(:,3), mrordinates(:,3), legendLbls, colors, dingbats, sizes)

