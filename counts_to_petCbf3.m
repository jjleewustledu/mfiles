% COUNTS_TO_PETCBF3
%
% Usage:  cbf = counts_to_petCbf3(counts, aflow, bflow)
%
%         cbf    -> double matrix
%         counts -> double matrix
%         aflow  ->
%         bflow  ->
%
%       Herscovitch P, Markham J, Raichle ME. Brain blood flow measured
% with intravenous H2(15)O: I. theory and error analysis.
% J Nucl Med 1983;24:782ñ789
%       Videen TO, Perlmutter JS, Herscovitch P, Raichle ME. Brain
% blood volume, blood flow, and oxygen utilization measured with
% O-15 radiotracers and positron emission tomography: revised metabolic
% computations. J Cereb Blood Flow Metab 1987;7:513ñ516
%       Herscovitch P, Raichle ME, Kilbourn MR, Welch MJ. Positron
% emission tomographic measurement of cerebral blood flow and
% permeability: surface area product of water using [15O] water and
% [11C] butanol. J Cereb Blood Flow Metab 1987;7:527ñ542
%

function cbf = counts_to_petCbf3(counts, AFlow, BFlow)

    BUTANOL_CORR = 1;
    pid = 'single patient';

	if AFlow < 0, 
		disp(['WARNING:  Aflow was ' num2str(AFlow) ' for PID ' pid '.']); end
	if BFlow < 0, 
		disp(['WARNING:  Bflow was ' num2str(BFlow) ' for PID ' pid '.']); end
    switch class(counts)
        case 'dip_image'
            counts = double(counts);
        case 'double'
        otherwise
            error(help('counts_to_petCbf3'));
    end
    counts = squeeze(counts);
    
	cbf = counts.*(AFlow*counts + BFlow);

	if (BUTANOL_CORR) 
        switch size(size(cbf),2)
            case 2
                cbf = dorank2(cbf, pid);
            case 3
                cbf = dorank3(cbf, pid);
            case 4
                cbf = dorank4(cbf, pid);
            otherwise
                error(['oops...   counts_to_petCbf does not support counts of rank ' ...
                       num2str(size(size(cbf),2))]);
        end
    end
    cbf = dip_image(squeeze(cbf));
    
    
    
    %---------------------------------------------------------------------------------------------------------
    
    function cbf2 = dorank2(arr, pid)  
        VERBOSE = 0;
        cbf2 = arr;
        for y = 1:size(arr,2)
            for x = 1:size(arr,1)
                try  
                    corr = mexFlowButanol(arr(x,y), 'j');
                    if isfinite(corr), 
                        cbf2(x,y) = corr; end
                catch
                    if VERBOSE,
                        disp(['counts_to_petCbf:  for pid -> ' pid ...
                          ' x -> ' num2str(x) ' y -> ' num2str(y) ...
                          ' butanol correction failed; returning AFlow/BFlow corrections']); end
                end
            end
        end

    function cbf3 = dorank3(arr, pid)      
        VERBOSE = 1;
        cbf3 = arr;
        for z = 1:size(arr,3)
            for y = 1:size(arr,2)
                for x = 1:size(arr,1)
                    try    
                        corr = mexFlowButanol(arr(x,y,z), 'j');
                        if isfinite(corr), 
                            cbf3(x,y,z) = corr; end
                    catch
                        if VERBOSE, 
                            disp(['counts_to_petCbf:  for pid -> ' pid ...
                              ' x -> ' num2str(x) ' y -> ' num2str(y) ' z -> ' num2str(z) ...
                              ' butanol correction failed; returning AFlow/BFlow corrections']); end
                    end
                end
            end
        end

    function cbf4 = dorank4(arr, pid) 
        VERBOSE = 0;
        cbf4 = arr;
        for t = 1:size(arr,4)
            for z = 1:size(arr,3)
                for y = 1:size(arr,2)
                    for x = 1:size(arr,1)
                        try    
                            corr = mexFlowButanol(arr(x,y,z,t), 'j');
                            if isfinite(corr), 
                                cbf4(x,y,z,t) = corr; end
                        catch
                            if VERBOSE,
                                disp(['counts_to_petCbf:  for pid -> ' pid ...
                                  ' x -> ' num2str(x) ' y -> ' num2str(y) ' z -> ' num2str(z) ...
                                  ' t -> ' num2str(t) ...
                                  ' butanol correction failed; returning AFlow/BFlow corrections']); end
                        end
                    end
                end
            end
        end

                
                
                

