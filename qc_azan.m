function crv_deconv = qc_azan(crvfile, pmod_factor, hct, opts)
%  crvfile {mustBeFile}: e.g., 'R01AA_103_v2_D1.crv'
%  pmod_factor {mustBeScalarOrEmpty} : ~ 40:80
%  hct {mustBeScalarOrEmpty} % males -> 45.5, females -> 42, unknown sex -> 43.75
%  opts.t0 {mustBeScalarOrEmpty} = 14.9
%  opts.idx0 double : 2760
%  opts.idxf double : 3155
%  opts.tracer {mustBeTextScalar} = 'azan'
%  opts.isotope {mustBeTextScalar} = '18F'

arguments
    crvfile {mustBeFile}
    pmod_factor {mustBeScalarOrEmpty} 
    hct {mustBeScalarOrEmpty} = 43.75
    opts.t0 {mustBeScalarOrEmpty} = 14.9
    opts.idx0 double = []
    opts.idxf double = []
    opts.tracer {mustBeTextScalar} = 'azan'
    opts.isotope {mustBeTextScalar} = '18F'
end
if hct < 1; hct = 100*hct; end
opts.tracer = lower(opts.tracer);
inveff = (1/0.27)*pmod_factor; % per visible volume of cath

%% flatten baseline drift from tracer deposition in catheters
% crvc = mlswisstrace.CrvData('R01AA_105_v2_callibrated_D1.crv')
% plotAll(crvc)
% tail = mean(crvc, 1, datetime(2022,10,25, 16,50,21))
% crv = mlswisstrace.CrvData('R01AA_105_v2_D1.crv')
% plotAll(crv)
% crv2 = crv.flattenBaseline(baseline_t0=1, baseline_tf=datetime(2022,10,25, 15,46,21), measurement_tf=datetime(2022,10,25, 15,50,51), tail=tail)
% figure; plotAll(crv2)

crv = mlswisstrace.CrvData.createFromFilename(crvfile);
fileprefix = sprintf('%s%s_deconv', opts.tracer, crv.dateTag);
if isempty(opts.idx0)
    figure; plot(crv.coincidence)
    figure; plotAll(crv)
    return
end

M_ = crv.timetable().Coincidence(opts.idx0:opts.idxf)*inveff;
figure; plot(M_)
cath = mlswisstrace.Catheter_DT20190930( ...
    'Measurement', M_, ...
    't0', 14.9, ...
    'hct', hct, ...
    'tracer', opts.isotope); % t0 reflects rigid extension + Luer valve + cath in Twilite cradle
M = zeros(size(crv.timetable().Coincidence));
M(opts.idx0:opts.idxf) = cath.deconvBayes();
cath.plotall();
crv_deconv = copy(crv);
crv_deconv.filename = strcat(fileprefix, '.crv');
crv_deconv.coincidence = M/inveff;
crv_deconv.writecrv();
gr = (1 + sqrt(5))/2;
set(gcf, 'position', [1, 1, gr*500, 500])
set(gca, 'FontSize', 14)
savefig(gcf, strcat(fileprefix, '.fig'), 'compact')
exportgraphics(gcf, strcat(fileprefix, '.png'), 'Resolution', 600)

