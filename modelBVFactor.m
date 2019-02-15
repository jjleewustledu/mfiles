
%

function oxy = modelBVFactor(pnum)
%% MODELBVFACTOR
% Usage:  oxy = modelBVFactor(pnum)
%
%         pnum:          string of form 'vc4354' or the corresponding int index
%                       from pnumList
%
%         oxy:          oxygen content from oo1 hdr files
%
%       Herscovitch P, Markham J, Raichle ME. Brain blood flow measured
% with intravenous H2(15)O: I. theory and error analysis.
% J Nucl Med 1983;24:782??789
%       Videen TO, Perlmutter JS, Herscovitch P, Raichle ME. Brain
% blood volume, blood flow, and oxygen utilization measured with
% O-15 radiotracers and positron emission tomography: revised metabolic
% computations. J Cereb Blood Flow Metab 1987;7:513??516
%       Herscovitch P, Raichle ME, Kilbourn MR, Welch MJ. Positron
% emission tomographic measurement of cerebral blood flow and
% permeability: surface area product of water using [15O] water and
% [11C] butanol. J Cereb Blood Flow Metab 1987;7:527??542

EXPRESSION = 'Blood Volume Factor\s*=\s*(?<bvfactor>\d+\.?\d*)';
dbase      = mlpatterns.PipelineRegistry.instance;
pimaging   = mlfsl.PETStudy(pnum);
contents   = {0};
filnam     = '';
labels     = {'oc1', 'oc1_g3', 'oc2', 'oc2_g3'};
for lbl = 1:2 %#ok<*FORFLG,*PFUNK>
    filnam = pimaging.hdrinfo_filename(labels{lbl});
    try
        fid = fopen(filnam);
        i = 1;
        while 1
            tline = fgetl(fid);
            if ~ischar(tline), break, end
            contents{i} = tline;
            i = i + 1;
        end
        fret = fclose(fid);
        disp('mfiles:Info', ['modelBVFactor:  fclose returned->' fret]);        
        break;
    catch ME %#ok<MUCTH>
        if (dbase.debugging)
            disp(ME); 
            warning('mfiles:IOWarning', ['modelBVFactor:  trouble with file ' filnam]);
        end
    end
end
if (dbase.debugging)
    for k = 1:length(contents)
        disp(contents{k}); end
end
try
    cline = contents{strmatch(' Blood Volume Factor', contents)};
    [~, names] = regexpi(cline, EXPRESSION,'tokens','names');
    oxy = str2double(names.bvfactor);
    disp(['mfiles:Info:  modelBVFactor.oxy->' num2str(oxy)]);
catch ME
    disp(ME.message);
    error('mfiles:InternalDataErr', ...
        ['modelBVFactor:  trouble extracting Blood Volume Factor from ' filnam]);
end

