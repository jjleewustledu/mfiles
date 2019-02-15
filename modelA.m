%
% Usage:  a = modelA(pnum)
%
%         pnum:     string of form 'vc4354' or the corresponding int index
%                   from pnumList
%
%         a         -> [a1 a2 a3 a4] constants in quadratic equations
%                       a1 from water A
%                       a2 from water B
%                       a3 from O2 A
%                       a4 from O2 B
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

function a = modelA(pnum)

SUFFIXES = {'oo1_g3' 'oo1' };
switch (nargin)
    case 1
        pnum = mlfsl.ImagingComponent.ensurePnum(pnum);
    otherwise
        error('mfiles:InputParamsErr', help('modelA'));
end

contents = { 0 0 0 0 };
filenam  = '';
pimaging = mlfsl.PETStudy(pnum);
for s = 1:length(SUFFIXES) %#ok<*FORFLG,*PFUNK>
    filnam = pimaging.hdrinfo_filename(SUFFIXES{s});
    try
        fid = fopen(filnam);
        while 1
            tline = fgetl(fid);
            if ~ischar(tline),   break,   end
            if (strcmp('Coef', tline(4:7)))
                switch(tline(2:22))
                    case 'A Coefficient (Water)'
                        contents{1} = tline;
                    case 'B Coefficient (Water)'
                        contents{2} = tline;
                    case 'A Coefficient (Oxygen'
                        contents{3} = tline;
                    case 'B Coefficient (Oxygen'
                        contents{4} = tline;
                end
            end
        end
        fclose(fid);
        break;
    catch ME
        disp(ME);
        error('mfiles:InternalDataErr', ['modelA:  could not process file ' filnam]);
    end
end

try
    for j = 1:4
        cline = contents{j};
        a(j)  = str2double(cline(strfind(cline, '=')+2:end)); %#ok<AGROW>
    end
catch ME
    disp(['modelA:  could not find model coefficients a from file ' filnam]);
    disp( '         with contents:');
    for k = 1:4
        disp(contents{k});
    end
    error('mfiles:InternalDataErr', ME);
end

