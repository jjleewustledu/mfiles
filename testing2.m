% TESTING

fine_interior = interior & grey;
nocsf = fine_interior;

[ho1_0mm ho1_0mm_imgCheck] = lpeekVoxels(ho1(:,:,0,0), interior(:,:,0,0), nocsf(:,:,0,0), 0, [0.9375 0.9375]);
but1Cbf_0mm          = counts_to_petCbf(ho1_0mm, 'vc4153');
but1Cbf_0mm_imgCheck = dip_image(counts_to_petCbf(ho1_0mm_imgCheck, 'vc4153')); 

[bayesF_44mm bayesF_44mm_imgCheck] = lpeekVoxels(bayesF, nocsf(:,:,0,0), nocsf(:,:,0,0), 4.4, [0.9375 0.9375]);
bayesF_44mm_imgCheck = dip_image(bayesF_44mm_imgCheck);

[mlemF_44mm  mlemF_44mm_imgCheck]  = lpeekVoxels(mlemF,  nocsf(:,:,0,0), nocsf(:,:,0,0), 4.4, [.9375 .9375]);
mlemF_44mm_imgCheck  = dip_image(mlemF_44mm_imgCheck);

figure

hbayes = plot(but1Cbf_0mm, bayesF_44mm, 'k. ');
set(hbayes, 'MarkerEdgeColor', [.2 .2 1],   'MarkerSize', 4, 'LineStyle', 'none')
set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
set(gcf, 'Color', 'white');
axis square;
xlabel('P.S.-corrected PET CBF / (mL/min/100 g tissue)', 'FontSize',14)
ylabel('DSC Bayesian F / arbitrary', 'FontSize',14)

figure

hmlem = plot(but1Cbf_0mm, mlemF_44mm, 'k. ');
set(hmlem, 'MarkerEdgeColor', [1 .2 .2],   'MarkerSize', 4, 'LineStyle', 'none')
set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
set(gcf, 'Color', 'white');
axis square;
xlabel('P.S.-corrected PET CBF / (mL/min/100 g tissue)', 'FontSize',14)
ylabel('DSC MLEM F / arbitrary', 'FontSize',14)

