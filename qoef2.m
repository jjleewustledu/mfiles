%% QOEF2
%  Usage:  qs = qoef2(pnum, showimgs)
%                                 ^
%                                 optional boolean
function qs = qoef2(pnum, showimgs)

progrm = 'qoef2';
if (nargin < 2); showimgs = true; end
USE_FILTER = false;
imaging = mlfsl.ImagingComponent(pnum);
disp([progrm ':  processing patient ' pnum ' from study ' imaging.sid]);
qs = qoef(pnum, USE_FILTER);

if ~(7 == exist([ imaging.pnumPath 'qBOLD'], 'dir'))
    system(['cd ' imaging.pnumPath '; mkdir qBOLD']);
else
    system(['cd ' imaging.pnumPath 'qBOLD']);
end
save([imaging.pnumPath 'qBOLD/qoef2_qs_' datestr(now,30) '.mat'], 'qs');

manage_nii(qs.map_coef2,       'map_coef2')
manage_nii(qs.map_corr,        'map_corr')
manage_nii(qs.map_cs,          'map_cs')
manage_nii(qs.map_delta_f,     'map_delta_f')
manage_nii(qs.map_delta_w,     'map_delta_w')
manage_nii(qs.map_error,       'map_error')
manage_nii(qs.map_rb,          'map_rb')
manage_nii(qs.map_rb_phase,    'map_rb_phase')
manage_nii(qs.map_s,           'map_s')
manage_nii(qs.map_s2,          'map_s2')
manage_nii(qs.map_shift_phase, 'map_shift_phase')
manage_nii(qs.map_t2,          'map_t2')
manage_nii(qs.map_t2_2,        'map_t2_2')
manage_nii(qs.mask,            'mask')
manage_nii(qs.oef,             'oef')
manage_nii(qs.t2_w,            't2_w')
manage_nii(qs.dbv,             'dbv')

if (showimgs)
    dmap_coef2       = dip_image(qs.map_coef2);
    dmap_corr        = dip_image(qs.map_corr);
    dmap_cs          = dip_image(qs.map_cs);
    dmap_delta_f     = dip_image(qs.map_delta_f);
    dmap_delta_w     = dip_image(qs.map_delta_w);
    dmap_error       = dip_image(qs.map_error);
    dmap_rb          = dip_image(qs.map_rb);
    dmap_rb_phase    = dip_image(qs.map_rb_phase);
    dmap_s           = dip_image(qs.map_s);
    dmap_s2          = dip_image(qs.map_s2);
    dmap_shift_phase = dip_image(qs.map_shift_phase);
    dmap_t2          = dip_image(qs.map_t2);
    dmap_t2_2        = dip_image(qs.map_t2_2);
    dmask            = dip_image(double(qs.mask));
    doef             = dip_image(qs.oef);
    dt2_w            = dip_image(qs.t2_w);
    ddbv             = dip_image(qs.dbv);

    h     = zeros(1, 17);
    h(1)  = dipshow(dmap_coef2,       'percentile', 'grey');
    h(2)  = dipshow(dmap_corr,        'percentile', 'grey');
    h(3)  = dipshow(dmap_cs,          'percentile', 'grey');
    h(4)  = dipshow(dmap_delta_f,     'percentile', 'grey');
    h(5)  = dipshow(dmap_delta_w,     'percentile', 'grey');
    h(6)  = dipshow(dmap_error,       'percentile', 'grey');
    h(7)  = dipshow(dmap_rb,          'percentile', 'grey');
    h(8)  = dipshow(dmap_rb_phase,    'percentile', 'grey');
    h(9)  = dipshow(dmap_s,           'percentile', 'grey');
    h(10) = dipshow(dmap_s2,          'percentile', 'grey');
    h(11) = dipshow(dmap_shift_phase, 'percentile', 'grey');
    h(12) = dipshow(dmap_t2,          'percentile', 'grey');
    h(13) = dipshow(dmap_t2_2,        'percentile', 'grey');
    h(14) = dipshow(dmask,            'percentile', 'grey');
    h(15) = dipshow(doef,             'percentile', 'grey');
    h(16) = dipshow(dt2_w,            'percentile', 'grey');
    h(17) = dipshow(ddbv,             'percentile', 'grey');

    PRCNT = 400;
    SLICE = 7;
    for i = 1:17
        diptruesize(h(i), PRCNT)
        dipmapping( h(i), 'slice', SLICE)
    end
end

    %% MAKE_TEMPLATE
    %  Usage: tmpl = make_template(descrip, filepfx)
    %                                    ^        ^
    %                   descriptive string        filename string
    function  tmpl = make_template(descrip, filepfx)
        imaging   = mlfsl.ImagingComponent(pnum);
        tmpl = mlfourd.NIfTI.load([imaging.npnumPath '/qBOLD_reprocessed/template_qBOLD.nii.gz']);
        tmpl.hdr.hist.descrip = [imaging.npnum ' ' imaging.pnum ' qBOLD ' descrip ' '];
        tmpl.fileprefix = filepfx;
    end % function make_template

    %% MANAGE_NII
    function desc1 = manage_nii(img, filepfx, descrip)
        if (nargin < 3); descrip = filepfx; end
        COMMENT = 'reprocessed 2009apr15';
        tmpl    = make_template(descrip, filepfx);
        nii     = tmpl.makeSimilar(img, [filepfx ' ' COMMENT], filepfx);
        desc1   = nii.hdr.hist.descrip;
        qpath = '';
        if (imaging.hasFsl); qpath = 'qBOLD/'; end
        save_nii(nii, [imaging.pnumPath qpath filepfx mlfourd.NIfTIInfo.FILETYPE_EXT]);
    end % function manage_nii
end
