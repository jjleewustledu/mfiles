function this = cnami_standalone(sesdir, opts)
%% CNAMI_STANDALONE is a top-level wrapper for
%  https://github.com/jjleewustledu/mlwong
%
% Args:
% sesdir {mustBeFolder} = pwd
% opts.final_calc {mustBeFile}; e.g., "chemistry/2023-06-29_Final_Calculation.csv"
% opts.fractions {mustBeFile}; e.g., "chemistry/2023-06-29_RO948_Metabolite_Fractions.csv"
% opts.fileprefix {mustBeTextScalar} = "sub-unknown_ses-unknown"
% opts.toi {mustBeTextScalar}; e.g., "29-Jun-2023 13:10:23"
% opts.crv_filename {mustBeFile}; e.g., "twilite/R21_016_PET2_06292023_D1.crv"
% opts.hct {mustBeText} = "43.75"
% opts.t0_forced {mustBeText} = "47"

arguments
    sesdir {mustBeFolder} = pwd
    opts.final_calc {mustBeFile} % = "chemistry/2024-11-01_Final Calculation.csv"
    opts.fractions {mustBeFile} % = "chemistry/2024-11-01_VAT_Metabolite_Fractions.csv"
    opts.fileprefix {mustBeTextScalar} = "sub-unknown_ses-unknown"
    opts.toi {mustBeTextScalar} % = "1-Nov-2024 13:25:49"
    opts.crv_filename {mustBeFile} % = "twilite/EVA_109_20241101_Scan1_D3.crv"
    opts.hct {mustBeText} = "43.75"
    opts.t0_forced {mustBeText} = "47"
    opts.time_cliff {mustBeText} = "300"
    opts.do_Hill {mustBeText} = "0"
end
opts.toi = datetime(opts.toi, TimeZone = "local");
assert(contains(opts.crv_filename, ".crv"))
crv_ = mlswisstrace.CrvData(opts.crv_filename);

reneau = mlwong.ReneauAdapter( ...
    sesdir=sesdir, ...
    final_calc=opts.final_calc, ...
    fractions=opts.fractions, ...
    fileprefix=opts.fileprefix); 
reneau.readtables();
reneau.writetables();

this = mlwong.Ro948Kit( ...
    toi=opts.toi, ...
    crv=crv_, ...
    fileprefix=opts.fileprefix, ...
    hct = str2double(opts.hct), ...
    t0_forced = str2double(opts.t0_forced), ...
    timeCliff = str2double(opts.time_cliff), ...
    do_Hill=str2double(opts.do_Hill));
%disp(this)
call(this)
