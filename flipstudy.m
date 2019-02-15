function [niis, fprefixes] = flipstudy(pnum, flipflag)
      
import mlfourd.* mlfsl.*;
assert(ischar(pnum));
imaging = ImagingComponent(pnum);
cd([imaging.pnumPath 'fsl']); %#ok<MCCD>

disp('working with fileprefixes:');
fprefixes = {'fast_pve_2', ...
             't1', 't1_mpr', 'ho1', 'oc1', 'oo1'} % 'parenchyma', 'fast_pve_0', 'fast_pve_1', 
niis = {[]};
for i = 1:length(fprefixes)
    fprefixes{i} = [fprefixes{i} '_xr3d'];
    niis{i} = NIfTI.load([fprefixes{i} mlfourd.NIfTId.FILETYPE_EXT]);
    niis{i}.img = dip_image(flip4d(niis{i}.img, flipflag));
    niis{i}.fileprefix = fprefixes{i};
    
end

% do all user interactions at once
for i = 1:length(fprefixes)
    niis{i}.dipshow;
    reply = input([fprefixes{i} ' look ok (y/n)? '], 's');
    if (~lstrfind(lower(reply), flipflag)); return; end
    system(['mv ' niis{i}.fileprefix mlfourd.NIfTId.FILETYPE_EXT ' ' niis{i}.fileprefix '_' datestr(now,30) mlfourd.NIfTId.FILETYPE_EXT]);
    niis{i}.save;
end

disp('qcbf/qcbv should be flipped individually');
