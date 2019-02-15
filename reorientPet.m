function output = reorientPet(input)
%% REORIENTPET flips images in the y-dimension, preserving x & z orientations;
%  intended for processing PET images which have been touched by ecatoanalyze, ecatto4dfp, 962to4dfp
%  Usage:  nifti = reorientPet(nifti) 
%
%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into svn repository $URL$ 
%% Developed on Matlab 8.4.0.150421 (R2014b) 
%% $Id$ 

switch (class(input))
    case 'mlfourd.NIfTI'
        output = input;
        output.img = flip4d(input.img, 'y');
        output.fileprefix = [output.fileprefix '_flipy'];
    case 'char'
        output = mlfourd.NIfTI.load(input);
        output.img = flip4d(output.img, 'y');        
        output.fileprefix = [output.fileprefix '_flipy'];
        output.save;
        output = output.fqfilename;
    case {'double' 'single'}
        output = flip4d(input, 'y');
    otherwise
        error('mfiles:unsupportedDatatype', 'reorientPet does not support type-class %s', class(input));
end









% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mlcvl/mfiles/reorientPet.m] ======  
