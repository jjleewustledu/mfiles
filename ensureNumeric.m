function num = ensureNumeric(entity, preference)
%% ENSURENUMERIC ... 
%   
%  Usage:  numeric = ensureNumeric(entity, preference) 
%          ^ 
%  Version $Revision$ was created $Date$ by $Author$  
%  and checked into svn repository $URL$ 
%  Developed on Matlab 7.10.0.499 (R2010a) 
%  $Id$ 
import mlfourd.*;
if (~exist('preference', 'var')); preference = 'single'; end

switch (preference)
    case 'int32'
        numtype = @int32;
    case 'int64'
        numtype = @int64;
    case 'single'
        numtype = @single;
    case 'double'
        numtype = @double;
    case 'dip_image'
        numtype = @dip_image;
    otherwise
        numtype = @double;
end

switch (class(entity))
    case numeric_types
        num = numtype(entity);
    case NIfTI.NIFTI_SUBCLASS
        num = numtype(entity.img);
    case 'cell'
        num = cell(size(entity));
        for c = 1:numel(entity)
            num{c} = numtype(entity{c});
        end
    case 'struct'
        try
            num = numtype(entity.img);
        catch ME
            handexcept(ME, ['mfiles.ensureNumeric.entity, class->' class(entity)]);
        end
    otherwise
        paramError('mfiles.ensureNumeric', 'class(entity)', class(entity));
end



end
% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/ensureNumeric.m] ======  
