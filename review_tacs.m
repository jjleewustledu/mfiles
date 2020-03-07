function review_tacs(folderExpr)

import mlfourd.ImagingContext2

workdir = fullfile(getenv('SINGULARITY_HOME'), folderExpr, 'resampling_restricted', '');
assert(isfolder(workdir))
cd(workdir)
for j = asrow(glob('*.json'))
    try
        tpref = lower(strrep(myfileprefix(j{1}), '_', ''));
        T1totrt4 = sprintf('T1001_to_%s_t4', tpref);
        mlbash(sprintf('t4_inv %s_to_T1001_t4 %s', tpref, T1totrt4));
        mlbash(sprintf('t4img_4dfp %s T1001 T1001_on_%s -O%s_avgt', T1totrt4, tpref, tpref));
        mlbash(sprintf('nifti_4dfp -N -4 brain.nii brain.4dfp.hdr'));
        mlbash(sprintf('nifti_4dfp -N -4 wmparc.nii wmparc.4dfp.hdr'));
        mlbash(sprintf('t4img_4dfp %s wmparc wmparc_on_%s -O%s_avgt', T1totrt4, tpref, tpref));
        tr = ImagingContext2([tpref '.4dfp.hdr']);
        wm = ImagingContext2(['wmparc_on_' tpref '.4dfp.hdr']);
        wm = wm.binarized;
        tr1d = tr.volumeAveraged(wm);
        J = jsondecode(fileread(j{1}));
        times = cumsum(J.taus');
        
        h = figure;
        plot(times, tr1d.nifti.img);
        subS = basename(dirname(pwd));
        re = regexp(tpref, '(?<tracer>\w+)dt(?<date>\d+)', 'names');
        title(sprintf('%s\_%s\_%s', subS, re.tracer, re.date))
        xlabel('time / s')
        ylabel('specific activity / (Bq/mL)')
        saveas(h, [tpref '_tac.fig'])
        saveas(h, [tpref '_tac.png'])
        close(h)
        
        deleteExisting(['T1001_on_' tpref '.4dfp.*'])        
        deleteExisting(['wmparc_on_' tpref '.4dfp.*'])
        deleteExisting(T1totrt4)
    catch ME
        handwarning(ME)
    end
end
