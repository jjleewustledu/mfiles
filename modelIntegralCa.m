%
% Usage:  integralCa = modelIntegralCa(pid)
%
%         pid:          string of form 'vc4354' or the corresponding int index
%                       from pidList
%
%         integralCa:   \int_{T_1}^{T_2} C_{a}(t) dt (Integral of Blood Counts from scan start)
%
%       Herscovitch P, Markham J, Raichle ME. Brain blood flow measured
% with intravenous H2(15)O: I. theory and error analysis.
%       Videen TO, Perlmutter JS, Herscovitch P, Raichle ME. Brain
% blood volume, blood flow, and oxygen utilization measured with
% O-15 radiotracers and positron emission tomography: revised metabolic
%       Herscovitch P, Raichle ME, Kilbourn MR, Welch MJ. Positron
% emission tomographic measurement of cerebral blood flow and
% permeability: surface area product of water using [15O] water and
%

function integralCa = modelIntegralCa(pnum)

EXPRESSION = 'Integral of Blood Counts \(from scan start\)\s*=\s*(?<integral>\d+\.?\d*)'; % \w+
SUFFIXES   = {'oc1_g3' 'oc1'};
switch (nargin)
    case 1
        pnum = mlfsl.ImagingComponent.ensurePnum(pnum);
    otherwise
        error('mfiles:InputParamsErr', help('modelIntegralCa'));
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
        warning('mfiles:IOErr', ['modelIntegralCa:  could not process file ' filnam]);
    end
end

if (pipe.debugging)
    for k = 1:length(contents)
        disp(contents{k}); end
end
try
    for j = 1:length(contents)
        cline = contents{j};
        if (strcmp('Integral', cline(2:9)))
            [~, names] = regexpi(cline, EXPRESSION,'tokens','names');
            integralCa = str2double(names.integral);
            break;
        end
    end
catch ME
    disp(ME.message);
    error('mfiles:InternalDataErr', ...
        ['modelIntegralCa:  could not find Integral of Blood Counts from scan start from file ' filnam]);
end


