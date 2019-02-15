function testsForCihat(varargin)
%% TESTSFORCIHAT
%  Usage:  >> testsForCihat([working_directory_for_tests])
%  e.g.    >> testsForCihat
%  e.g.    >> testsForCihat('/data/anlab/jjlee')
%  e.g.    >> testsForCihat("Z:\anlab\jjlee")
%
%  @param requires access to /data/anlab/jjlee or Z:\anlab\jjlee for
%         appropriate network drive Z:
%  @param requires in your path:  'Z:\anlab\jjlee', 'Z:\anlab\jjlee\mfiles'.
%  @return test results corresponding to 
%  >> cd('Z:\anlab\jjlee\SynchingExperimentWithoutActivity/029Abd_MRAC_PET_Raw_Data')
%  >> testObj = mlan.SortListmode( ...
%         'fileprefix', '1.3.12.2.1107.5.2.38.51010.30000017042814001792100000046', ...
%         'fileMRbin', 'BinningTable.txt', ...
%         'Nbin', 10);             
%  >> testObj.estimatePETTimingsLM
%  >> cd('Z:\anlab\jjlee\RadioactivePhantom_July14_2017')
%  >> testObj = mlan.SortListmode( ...
%         'fileprefix', 'PET_ACQ_62_20170714165800-0', ...
%         'fileMRbin', 'BinningTable.txt', ...
%         'Nbin', 10, ...
%         'tstep', 164.92);
%  >> testObj.sampleLM(3000, 3000)
%  Please cf. function details for additional directory changes.

assert(isdir('Z:\anlab\jjlee'), 'Please ensure access to Z:\anlab\jjlee');
ip = inputParser;
addOptional(ip, 'workpth', 'Z:\anlab\jjlee', @isdir);
parse(ip, varargin{:})
fprintf('TESTSFORCIHAT will be working in directory %s\n', ip.Results.workpth);
cd(ip.Results.workpth);

fprintf('TESTSFORCIHAT is adding to your path:  Z:\\anlab\\jjlee, Z:\\anlab\\jjlee\\mfiles\n');
path('Z:\anlab\jjlee', path);
path('Z:\anlab\jjlee\mfiles', path);

assert(logical(exist('mlan.SortListmode', 'class')), ...
    'Please add /data/jjlee or equivalent network location to your Matlab path; See also addpath.');
assert(logical(exist('myfileparts', 'file')), ...
    'Please add /data/jjlee/mfiles or equivalent network location to your Matlab path; See also addpath.');
assert(isdir('RadioactivePhantom_July14_2017'), 'directory RadioactivePhantom_July14_2017 is needed for testing');
assert(isdir('SynchingExperimentWithoutActivity/029Abd_MRAC_PET_Raw_Data'), 'directory SynchingExperimentWithoutActivity is needed for testing');
      
%% estimatePETTimingsLM
fprintf('TESTSFORCIHAT is testing mlan.SortListmode.estimatePETTimingsLM\n');

try    
    pwd1 = pushd('SynchingExperimentWithoutActivity/029Abd_MRAC_PET_Raw_Data');            
    testObj = mlan.SortListmode( ...
         'fileprefix', '1.3.12.2.1107.5.2.38.51010.30000017042814001792100000046', ...
         'fileMRbin', 'BinningTable.txt', ...
         'Nbin', 10);             
    T_ACQ_PET = testObj.estimatePETTimingsLM;
    fprintf('expected 306766; test obtained %i\n', T_ACQ_PET);
    assert(logical(exist('1.3.12.2.1107.5.2.38.51010.30000017042814001792100000046_T_ACQ_PET.log', 'file')), 'test failed:  log file missing');
    fprintf('log file contains:\n');
    system('type 1.3.12.2.1107.5.2.38.51010.30000017042814001792100000046_T_ACQ_PET.log');
    popd(pwd1);            

catch ME
    handerror(ME);
end   

%% sampleLM
fprintf('\nTESTSFORCIHAT is testing mlan.SortListmode.sampleLM\n');

try
    pwd2 = pushd('RadioactivePhantom_July14_2017');
    testObj = mlan.SortListmode( ...
         'fileprefix', 'PET_ACQ_62_20170714165800-0', ...
         'fileMRbin', 'BinningTable.txt', ...
         'Nbin', 10, ...
         'tstep', 164.92);
    testObj.sampleLM(3000, 3000);
    assert(logical(exist('PET_ACQ_62_20170714165800-0-t3000-dt3000-000.s', 'file')));
    assert(logical(exist('PET_ACQ_62_20170714165800-0-t3000-dt3000-000.s.hdr', 'file')));
    popd(pwd2); 
    
catch ME
    handerror(ME);
end 

%% e7_recon
fprintf('TESTSFORCIHAT does not yet support mlan.SortListmode.e7_recon\n');

fprintf('\nTESTSFORCIHAT is finished.\n')


