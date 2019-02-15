% TESTING

fine_interior = interior & grey;
nocsf = fine_interior; 

[ho1_100mm ho1_100mm_imgCheck] = lpeekVoxels(ho1(:,:,0,0), nocsf(:,:,0,0), nocsf(:,:,0,0), 10, [0.9375 0.9375]);
but1Cbf_100mm          = counts_to_petCbf(ho1_100mm, 'vc4153');
but1Cbf_100mm_imgCheck = dip_image(counts_to_petCbf(ho1_100mm_imgCheck, 'vc4153')); 

[bayesF_100mm bayesF_100mm_imgCheck] = lpeekVoxels(bayesF, nocsf(:,:,0,0), nocsf(:,:,0,0), 10.64, [0.9375 0.9375]);
bayesF_100mm_imgCheck = dip_image(bayesF_100mm_imgCheck);

[mlemF_100mm  mlemF_100mm_imgCheck]  = lpeekVoxels(mlemF,  nocsf(:,:,0,0), nocsf(:,:,0,0), 10.64, [.9375 .9375]);
mlemF_100mm_imgCheck  = dip_image(mlemF_100mm_imgCheck);

figure

hbayes = plot(but1Cbf_100mm, bayesF_100mm, 'k. ');
set(hbayes, 'MarkerEdgeColor', [.2 .2 1],   'MarkerSize', 4, 'LineStyle', 'none')
set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
set(gcf, 'Color', 'white');
axis square;
xlabel('P.S.-corrected PET CBF / (mL/min/100 g tissue)', 'FontSize',14)
ylabel('DSC Bayesian F / arbitrary', 'FontSize',14)

figure

hmlem = plot(but1Cbf_100mm, mlemF_100mm, 'k. ');
set(hmlem, 'MarkerEdgeColor', [1 .2 .2],   'MarkerSize', 4, 'LineStyle', 'none')
set(gca, 'FontName', 'Helvetica');
set(gca, 'FontSize', 14);
set(gcf, 'Color', 'white');
axis square;
xlabel('P.S.-corrected PET CBF / (mL/min/100 g tissue)', 'FontSize',14)
ylabel('DSC MLEM F / arbitrary', 'FontSize',14)

