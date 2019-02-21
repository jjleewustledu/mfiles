function p = p_snippet(pid, p, docbv)

assert(nargin > 0);
import mlfourd.* mlfsl.*;
disp('starting p_snippet....................................................');
if (nargin > 1); disp('struct p -> '); disp(p); end
if (nargin < 3); docbv = true; end
imaging = mlfsl.ImagingComponent(pid);


% PARENCHYMA/FG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd(imaging.roiPath); pwd; %#ok<*MCCD>
parenchyma = NIfTI.load('parenchyma_xr3d.nii.gz');
[hh,dd] = reviewimg(parenchyma, 'existing parenchyma_xr3d'); 
disp('pve files found:');
ls -l fast_pve*
Npve = input('how many pve elements will you examine (0 to skip pve construction)? ');
if (Npve > 0)
    fg = cell(1,Npve);
    flast = 0;
    for f = 0:Npve-1
        try
            fg{f+1} = NIfTI.load(['fast_pve_' num2str(f) '_xr3d.nii.gz']);
            flast   = f;
        catch ME  %#ok<*MUCTH,*NASGU>
            disp(['could not find fast_pve_' num2str(f) '_xr3d.nii.gz...  ending search for now...']);
            if (f > 0); flast = f-1; break; end
        end
    end
    assert(flast <= length(fg));
    for f = 1:length(fg)
        [hh,dd] = reviewimg(fg{f}, ['fast_pve_' num2str(f-1)], hh, dd);
    end
    reply  = [];
    while (isempty(reply))
        reply = input('pve elements to include in new fg (e.g., [0 2])? ');
    end
    sumimg = zeros(size(fg{1}));
    disp(['length of fg-cell-->' num2str(length(fg))]);
    for f = 0:length(reply)-1
        sumimg = sumimg + fg{reply(f+1)+1}.img;
    end
    fgnew = fg{1}.makeSimilar(sumimg, 'parenchyma_xr3d', 'parenchyma_xr3d');
    disp('NIfTI fgnew  ->'); disp(fgnew);
    [hh,dd] = reviewimg(fgnew, 'the new fg mask', hh, dd);
    reply2 = input(['ok to replace ' fgnew.fqfn ' (y/n)? '], 's');
    if (~lstrfind(lower(reply2), 'y')); return; end
    system(['mv ' fgnew.fqfn ' ' imaging.roiPath fgnew.fileprefix '_' datestr(now,30) NIfTIInfo.FILETYPE_EXT]);
    fgnew.save;
    clear fg fgnew sumimg
end
p.(pid).parenchyma = parenchyma;



% T1 & T2 STRUCTURAL IMAGING %%%%%%%%%%%%%%%%%%%
t1 = NIfTI.load('t1_mpr_xr3d.nii.gz');
[hh,dd] = reviewimg(t1, 't1 mpr', hh, dd);
%p.(pid).t1 = t1;
t2 = NIfTI.load('t2_on_t1.nii.gz');
[hh,dd] = reviewimg(t2, 't2 space', hh, dd);
%p.(pid).t2 = t2;
try
    ir = NIfTI.load('ir_on_t1.nii.gz');
    [hh,dd] = reviewimg(ir, 'ir space', hh, dd);
%    p.(pid).ir = ir;
catch ME 
    disp('did not find IR series');
end
clear t1 t2 ir


% PET & MR PERFUSION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ho          = mlpet.PETBuilder.PETfactory(imaging.pid, 'ho', [0 0 0], [1 1 1]);
%[hh,dd] = reviewimg(ho, 'ho', hh, dd);
%p.(pid).ho = ho;
pcbf_101010 = mlpet.PETBuilder.PETfactory(imaging.pid, 'cbf', [10 10 10], [1 1 1]);
[hh,dd] = reviewimg(pcbf_101010, 'pcbf', hh, dd);
p.(pid).pcbf_101010 = pcbf_101010;
qcbf_101010 = MRIBuilder.MRfactory(imaging.pid, 'qcbf', [10 10 10], [1 1 1]);
[hh,dd] = reviewimg(qcbf_101010, 'qcbf', hh, dd);
p.(pid).qcbf_101010 = qcbf_101010;
if (docbv)
%    oc          = mlpet.PETBuilder.PETfactory(imaging.pid, 'oc', [0 0 0], [1 1 1]);
%    [hh,dd] = reviewimg(oc, 'oc', hh, dd);
%    p.(pid).oc = oc;
    pcbv_101010 = mlpet.PETBuilder.PETfactory(imaging.pid, 'cbv', [10 10 10], [1 1 1]);
    [hh,dd] = reviewimg(pcbv_101010, 'pcbv', hh, dd);
    p.(pid).pcbv_101010 = pcbv_101010;
    qcbv_101010 = MRIBuilder.MRfactory(imaging.pid, 'qcbv', [10 10 10], [1 1 1]);
    [hh,dd] = reviewimg(qcbv_101010, 'qcbv', hh, dd);
    p.(pid).qcbv_101010 = qcbv_101010;
end
p.(pid).sliceidx = -1;
while (p.(pid).sliceidx < 0)
       p.(pid).sliceidx = input('please select a slice index for figures (matlab indexing): ');
end
sidx       = p.(pid).sliceidx;
slicefield = ['slice' num2str(sidx)];
p.(pid).(slicefield).qcbf = qcbf_101010.img(:,:,sidx);
p.(pid).(slicefield).pcbf = pcbf_101010.img(:,:,sidx);
if (docbv)
    p.(pid).(slicefield).pcbv = pcbv_101010.img(:,:,sidx);
    p.(pid).(slicefield).qcbv = qcbv_101010.img(:,:,sidx);
end


try
    save(['p_D' datestr(now,30) '.mat'], 'p');
catch ME
    disp(ME)
end

