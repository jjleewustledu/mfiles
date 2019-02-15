
caudate1 = caudate.*parenchyma;
tone*~caudate1

cerebellum1 = cerebellum.*parenchyma;
tone*~cerebellum1

grey2 = immorph(grey.*parenchyma, 'dilate', 2);
grey2 = immorph(grey2, 'erode', 1);
tone*~grey2

hippocampus1 = hippocampus.*parenchyma;
tone*~hippocampus1

putamen1 = putamen.*parenchyma;
tone*~putamen1

thalamus1 = thalamus.*parenchyma;
tone*~thalamus1

white2 = immorph(white.*parenchyma, 'dilate', 2);
white2 = parenchyma.*white2.*~caudate1.*~cerebellum1.*~grey2.*~hippocampus1.*~putamen1.*~thalamus1;
tone*~white2


