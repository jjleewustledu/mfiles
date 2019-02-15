%
% Usage:  integral = modelIntegralO2Counts(pid)
%
%         pid:          string of form 'vc4354' or the corresponding int index
%                       from pidList
%
%         integral:     total oxygen counts from oo1 hdr files
%
%       Herscovitch P, Markham J, Raichle ME. Brain blood flow measured
% with intravenous H2(15)O: I. theory and error analysis.
%       Videen TO, Perlmutter JS, Herscovitch P, Raichle ME. Brain
% blood volume, blood flow, and oxygen utilization measured with
% O-15 radiotracers and positron emission tomography: revised metabolic
%       Herscovitch P, Raichle ME, Kilbourn MR, Welch MJ. Positron
% emission tomographic measurement of cerebral blood flow and
% permeability: surface area product of water using [15O] water and

function integral = modelIntegralO2Counts(pnum)

EXPRESSION = 'Total Oxygen Counts\s*=\s*(?<totaloxy>\d+\.?\d*E\+?\d*)';
SUFFIXES   = {'oo1_g3' 'oo1'};
switch (nargin)
    case 1
        pnum = mlfsl.ImagingComponent.ensurePnum(pnum);
    otherwise
        error('mfiles:InputParamsErr', help('modelIntegralO2Counts'));
end
contents = { 0 };
filnam   = '';
pipe     = mlpipeline.PipelineRegistry.instance;
pimaging = mlfsl.PETStudy(pnum);
for s = 1:length(SUFFIXES) %#ok<*FORFLG,*PFUNK>
    filnam = pimaging.hdrinfo_filename(SUFFIXES{s});
    try
        fid = fopen(filnam);
        i = 1;
        while 1
            tline = fgetl(fid);
            if ~ischar(tline),   break,   end
            contents{i} = tline;
            i = i + 1;
        end
        fclose(fid);
        break;
    catch ME
        disp(ME);
        warning('mfiles:IOErr', ...
            ['modelIntegralO2Counts:  could not process file ' filnam]);
    end
end

if (pipe.debugging)
    for k = 1:length(contents)
        disp(contents{k}); end
end

try
    for j = 1:length(contents)
        cline = contents{j};
        if (strcmp('Total', cline(2:6)))
            [~, names] = regexpi(cline, EXPRESSION,'tokens','names');
            integral = str2double(names.totaloxy);
        end
    end
catch ME
    disp();
    disp(ME.message);
    error('mfiles:InternalDataErr', ...
         ['modelIntegralO2Counts:  could not find Blood Volume Factor from file ' filnam]);
end

