function [aflow, bflow] = modelFlows(pnum)
    %% MODELFLOWS
    %
    %  Usage:  [aflow bflow] = modelFlows(pnum)
    %
    %         pnum:         string of form 'vc4354' or the corresponding int index
    %                       from pnumList
    %
    %         aflow, bflow: values from ho1 hdr files
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
    
    import mlfourd.*;
    EXPRESSION = { ...
        'A Coefficient \(Flow\)\s*=\s*(?<aflow>\d+\.?\d*E-?\d*)' ...
        'B Coefficient \(Flow\)\s*=\s*(?<bflow>\d+\.?\d*E-?\d*)' };
    SUFFIXES   = {'ho1_g3' 'ho1'};
    
    dbase      = mlpatterns.PipelineRegistry.instance;
    switch (nargin)
		case 1
            pnum = mlfsl.ImagingComponent.ensurePnum(pnum);
		otherwise
			error('mfiles:InputParamsErr', help('modelFlows')); %#ok<MCHLP>
    end
    
    contents = {0};
    filnam   = '';
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
            warning('mfiles:IOErr', ['modelFlows:  could not process file ' filnam ' with fid ' num2str(fid)]);
        end
    end

    if (dbase.debugging)
        for k = 1:length(contents)
            disp(contents{k}); end
    end
    cline = '';
    try
        for j = 1:length(contents)
            cline = contents{j};
            if (strcmp('A Coef', cline(2:7)))
                [~, names] = regexpi(cline, EXPRESSION{1},'tokens','names');
                aflow = str2double(names.aflow);
            end
            if (strcmp('B Coef', cline(2:7)))
                [~, names] = regexpi(cline, EXPRESSION{2},'tokens','names');
                bflow = str2double(names.bflow);
            end
        end 
    catch ME
        disp(['modelFlows:  could not find Coeffients of flow from file ' filnam]);
        disp(ME.message);
        error('mfiles:InternalDataErr', ['modelFlows:  regexpi failed for ' cline]);
    end

