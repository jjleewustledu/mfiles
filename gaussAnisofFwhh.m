function img = gaussAnisofFwhh(img, blur, mmppix)
%% GAUSSANISOFFWHH is DEPRECATED.   Use mlfourd.NiiBrowser.gaussFullwidth.
disp(help('gaussAnisofFwhh'));
img = mlfourd.NiiBrowser.gaussAnisof(img, blur, mmppix, 0.5);

