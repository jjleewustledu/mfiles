%
% Usage:  w = modelW(pid)
%
%         pid: 		string of form 'vc4354' or the corresponding int index
%                   from pidList
%
%         w:        factor to convert PET counts/pixel to well counts/mL (PETT Conversion Factor)
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

function w = modelW(pnum)

EXPRESSION = 'PETT Conversion Factor\s*=\s*(?<factor>\d+\.?\d*\w+)';
SUFFIXES   = {'oc1_g3' 'oc1'};
switch (nargin)
    case 1
        pnum = mlfsl.ImagingComponent.ensurePnum(pnum);
    otherwise
        error('mfiles:InputParamsErr', help('modelW'));
end

contents = { 0 };
filenam  = '';
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
        disp(ME.message);
        warning('mfiles:InternalDataErr', ...
            ['modelW:  could not process file ' filnam]);
    end
end

if (pipe.debugging)
    for k = 1:length(contents)
        disp(contents{k});
    end
end
try
    for j = 1:length(contents)
        cline = contents{j};
        if (strcmp('PETT', cline(2:5)))
            [~, names] = regexpi(cline, EXPRESSION,'tokens','names');
            w = str2double(names.factor);
            break;
        end
    end
catch ME
    switch (pnum)
        case 'p5702'
            error('mfiles:InternalDataErr', ...
                  'modelW:  w parameters for p5702 could not be found');
        otherwise
            disp(ME.message);
            error('mfiles:InternalDataErr', ...
                ['modelW:  could not find PETT Conversion Factor from file ' filnam]);
    end
end

