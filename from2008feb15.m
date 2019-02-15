parenchyma = fg0 & (deepgrey_dil2 | grey_dil1 | white0) & (~sinus0) & (~csf0)
parenchyma_ifh.imageModality = 'Siemens Magnatom Vision';
parenchyma_ifh.originating System = 'Siemens Magnetom Vision';
parenchyma_ifh.originatingSystem = 'Siemens Magnetom Vision';
parenchyma_ifh.imageModality = 'MRI';
parenchyma_programVersion = '7.5.0 (R2007b)';
parenchyma_conversionProgram = 'Matlab, Diplib';
parenchyma_nameOfDataFile = 'parenchyma.4dfp.img';
parenchyma_patientID = 'vc4420';
parenchyma_numberFormat = 'float';
parenchyma_bytesPerPixel = 4;
parenchyma_numberOfDimensions = 4;
parenchyma_scalingFactorX = 1;
parenchyma_scalingFactorY = 1;
parenchyma_scalingFactorZ = 2;
parenchyma_sliceThickness = 2;
parenchyma_ifh.sliceThickness = 2;
parenchyma_ifh.sliceThickness = 2;
parenchyma_ifh.scalingFactorZ = 2;
parenchyma_ifh.scalingFactorY = 1;
parenchyma_ifh.scalingFactorX = 1;
parenchyma_ifh.numberOfDimensions = 4;
parenchyma_ifh.bytesPerPixel = 4;
parenchyma_ifh.numberOfDimensions = 4;
parenchyma_ifh.numberFormat = 'float';
parenchyma_ifh.patientID = 'vc4420';
parenchyma_ifh.nameOfDataFile = 'parenchyma.4dfp.img';
parenchyma_ifh.conversionProgram = 'Matlab, Diplib';
parenchyma_ifh.programVersion = '7.5.0 (R2007b)';
parenchyma_ifh.lengthX = 256;
parenchyma_ifh.lengthY = 256;
parenchyma_ifh.lengthZ = 32;
parenchyma_ifh.lengthT = 1;
parenchyma_ifh.parameterFilename = '/usr/appl/proto/016/c/head/Colin_experiments/T1_cbv.prg';
parenchyma_ifh.sequenceDescription = '/usr/appl/work/azim/FLOWCOMP/fl3d_8rb_azim_rv.xkc'
parenchyma_ifh.comment = 'parenchyma = fg0 & (deepgrey_dil2 | grey_dil1 | white0) & (~sinus0) & (~csf0)';
nilio_writeIfh2(parenchyma_ifh, 'parenchyma.4dfp.ifh')
parenchyma_ifh.orientation = 2;
nilio_writeIfh2(parenchyma_ifh, 'parenchyma.4dfp.ifh')
parenchyma_ifh.sequenceFilename = parenchyma_ifh.sequenceDescription;
parenchyma_ifh.sequenceDescription = 'fl3d';
nilio_writeIfh2(parenchyma_ifh, 'parenchyma.4dfp.ifh')
parenchyma_xr3d = read4d('parenchyma_xr3d.4dfp.img', 'ieee-be', 'float', 256,256,8,1,0,0,0)
ho1 = read4d('p7552ho1_Xr3d.4dfp.img', 'ieee-be', 'float', 256, 256, 8, 1, 0,0,0)
ho1 = read4d('p5772ho1_Xr3d.4dfp.img', 'ieee-be', 'float', 256, 256, 8, 1, 0,0,0)
petFlows('p5772')
[aflow bflow] = petFlows('p5772')
petCbf = counts_to_petCbf3(ho1, aflow, bflow)
bayes = newim(size(ho1));
bayes(:,:,3,0) = read4d('F.0001.mean.4dfp.img', 'ieee-be', 'float', 256, 256, 1,1,0,0,0)
bayes(:,:,4,0) = read4d('F.0001.mean.4dfp.img', 'ieee-be', 'float', 256, 256, 1,1,0,0,0)
bayes(:,:,4,0) = read4d('F.0001.mean.4dfp.img', 'ieee-be', 'ascii', 256, 256, 1,1,0,0,0)
bayes(:,:,4,0) = read4d('F.0001.mean.Ascii', 'ieee-be', 'Ascii', 256, 256, 1,1,0,0,0)
bayes(:,:,4,0) = read4d('F.0001.mean.Ascii', 'ieee-be', 'ascii', 256, 256, 1,1,0,0,0)
slab = newim(size(bayes)); size(slab)
ones = dip_image(ones(256,256));
ones_slab = dip_image(ones(256,256));
slab(:,:,3,0) = ones_slab;
slab(:,:,4,0) = ones_slab;
slab
parenchyma_slab = parenchyma & slab
parenchyma_slab = squeeze(parenchyma) & squeeze(slab)
parenchyma_xr3d_slab = squeeze(parenchyma_xr3d) & squeeze(slab)
[petCbf_14mm_vec petCbf_14mm] = lpeekVoxels(squeeze(petCbf), parenchyma_xr3d_slab, parenchyma_xr3d_slab, [13.5 13.5 13.5], [0.9375 0.9375 6.0]);
[bayes_14mm_vec bayes_14mm] = lpeekVoxels(squeeze(bayes), parenchyma_xr3d_slab, parenchyma_xr3d_slab, [13.5 13.5 13.5], [0.9375 0.9375 6.0]);
petCbf_14mm
bayes_14mm
[bayes_14mm_vec bayes_14mm] = lpeekVoxels(squeeze(bayes), parenchyma_xr3d_slab, parenchyma_xr3d_slab, [13.5 13.5 13.5], [0.9375 0.9375 6.0]);
scatter(petCbf_14mm_vec, bayes_14mm_vec)
