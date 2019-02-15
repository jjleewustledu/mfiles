%COUNTS_TO_PETCBF2
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

function cbf = counts_to_petCbf2(counts, mask, pid)

	BUTANOL_CORR = 1;

    counts = squeeze(counts);
    mask   = squeeze(mask);
    if (size(mask) ~= size(counts))
        error(['counts_to_petCbf2:   size(counts) -> ' num2str(size(counts))...
               ' must equal size(mask) -> ' num2str(size(mask))]);
    end
    rank   = size(size(counts),2)
    
    [pid, p] = ensurePid(pid);
	[AFlow, BFlow] = petFlows(vcnum_to_pnum(pid));
	if AFlow < 0, 
		disp(['WARNING:  Aflow was ' num2str(AFlow) ' for PID ' pid '.']); end
	if BFlow < 0, 
		disp(['WARNING:  Bflow was ' num2str(BFlow) ' for PID ' pid '.']); end

	cbf = counts .* (AFlow .* counts + BFlow);

	if (BUTANOL_CORR)
        switch (rank)
            case 1
                try
                    cbf_corr = mexFlowButanol(cbf, 'j');
                    if isnumeric(cbf_corr), cbf = cbf_corr; end        
                catch
                    disp(['counts_to_petCbf2:  butanol correction failed for petpid ' num2str( vcnum_to_pnum(pid)) ...
                             '; returning AFlow/BFlow corrections only.']);
                end
            case 3
                dimx     = size(cbf,1);
                dimy     = size(cbf,2);
                dimz     = size(cbf,3);
                cbf_corr = newim(dimx, dimy, dimz);
                if strcmp('dip_image', class(cbf))
                    for z = 0:dimz-1
                        for y = 0:dimy-1
                            for x = 0:dimx-1
                                if mask(x,y,z)
                                    try
                                        cbf_corr(x,y,z) = mexFlowButanol(cbf(x,y,z), 'j');       
                                    catch
                                        %disp(['counts_to_petCbf2:  butanol correction failed for petpid ' num2str( vcnum_to_pnum(pid)) ...
                                        %         ' at coord ' num2str([x y z]) '; returning AFlow/BFlow corrections only.']);
                                        cbf_corr(x,y,z) = cbf(x,y,z);
                                    end
                                end
                            end
                        end
                    end
                    cbf = cbf_corr;
                else
                    error(['counts_to_petCbf2:   could not recognize ' class(cbf) '\n' ...
                           '                     only dip_image & double are supported.']);
                end
            otherwise
                error(['counts_to_petCbf2:  does not yet support rank -> ' num2str(rank)]);
        end  
	end

