[ho1_9mm_vec ho1_9mm] = lpeekVoxels(squeeze(ho1), tissue_mask, tissue_mask, 9, [1.71875 1.71875 0]);
[ho1_9mm_vec ho1_9mm] = lpeekVoxels(squeeze(ho1), tissue_mask, tissue_mask, [9 9 0], [1.71875 1.71875 6.5]);
[ho1_9mm_vec ho1_9mm] = lpeekVoxels(squeeze(ho1), tissue_mask, tissue_mask, [9 9 0], [1.71875 1.71875 6.5]);
[ho1_9mm_vec ho1_9mm] = lpeekVoxels(squeeze(ho1), tissue_mask, tissue_mask, [9 9 0], [1.71875 1.71875 6.5]);
[ho1_9mm_vec ho1_9mm] = lpeekVoxels(squeeze(ho1), tissue_mask, tissue_mask, [9 9 1], [1.71875 1.71875 6.5]);
[ho1_9mm_vec1 ho1_9mm1] = lpeekVoxels(squeeze(ho1), tissue_mask, tissue_mask, [9 9 0], [1.71875 1.71875 6.5]);

petCbf = counts_to_petCbf3(ho1, 2.316138e-6, 2.224848e-2)

[petCbf_14mm_vec petCbf_14mm] = lpeekVoxels(squeeze(petCbf), tissue_mask, tissue_mask, [13.5 13.5 13.5], [1.71875 1.71875 6.5]);

scatter(petCbv_9mm_vec, qCBV_9mm_vec)
[petCbv_14mm_vec petCbv_14mm] = lpeekVoxels(squeeze(petCbv), tissue_mask, tissue_mask, [13.5 13.5 13.5], [1.71875 1.71875 6.5]);
[petCbf_14mm_vec petCbf_14mm] = lpeekVoxels(squeeze(petCbf), tissue_mask, tissue_mask, [13.5 13.5 13.5], [1.71875 1.71875 6.5]);
help counts_to_petCbf3
petCbf = counts_to_petCbf3(ho1, 2.316138e-6, 2.224848e-2)
[petCbf_14mm_vec petCbf_14mm] = lpeekVoxels(squeeze(petCbf), tissue_mask, tissue_mask, [13.5 13.5 13.5], [1.71875 1.71875 6.5]);
[qCBF_14mm_vec qCBF_14mm] = lpeekVoxels(squeeze(qCBF), tissue_mask, tissue_mask, [13.5 13.5 13.5], [1.71875 1.71875 6.5]);
[qCBV_14mm_vec qCBV_14mm] = lpeekVoxels(squeeze(qCBV), tissue_mask, tissue_mask, [13.5 13.5 13.5], [1.71875 1.71875 6.5]);
scatter(petCbv_14mm_vec, qCBV_14mm_vec)
scatter(petCbf_14mm_vec, qCBF_14mm_vec)
