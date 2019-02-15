%PEEKINFO
%
% Usage:  info = peekInfo(kindRoi, kindImg, side, moment, tissue_ref, pops, means, errs, BAratio)
%
%         info will be a vector of doubles, ordered ascending
%         kindRoi is 'grey', 'basal', 'white' or 'allrois'
%         kindImg is 'F', 'cbfMlem', 'cbfOsvd', 'cbfSsvd', 'cbv...', 'mtt...' or 'ho1' 
%         side    is 'ipsi', 'contra' -lateral to lesions, otherwise both sides
%         moment  is 0 (pop), 1 (mean) or 2 (stderr)
%         tissue_ref is any int or string label
%         pops    is an array of moment0 values (NPID x NROI x NSIDE)
%         means
%         errs
%         BAratio
%
%         info contains { kindRoi, kindImg, ref. tissue, pid, hoFile, roi, side, moment }
%________________________________________________________________

function info = peekInfo(kindRoi, kindImg, side, moment, tissue_ref, pops, means, errs, BAratio)

switch (nargin)
    case {0,1}
        disp('peekCoords3(...) requires at least kindRoi and kindImg as args.');
        error(help('peekCoords3'));
    case 2
        side = 'both';
        moment = 1;
        white_matter_ref = 0;
    case 3
        moment = 1;
        white_matter_ref = 0;
    case 4
        white_matter_ref = 0;
    case 5
        pops = 0; means = 0; errs = 0; BAratio = 0;
    case 6
        means = 0; errs = 0; BAratio = 0;
    case 7
        errs = 0; BAratio = 0;
    case 8
        BAratio = 0;
    case 9
    otherwise
        error(help('peekCoords3'));
end

VERBOSE = 0;
NPID = 19;
if (strcmp('allrois', kindRoi)) 
    NROI = 3; 
else
    NROI = 1;
end
if (strcmp('ipsi', side) || strcmp('contra', side))
  NSIDE = 1;
else
  NSIDE = 2;
end
NFIELDS = nargin - 1;

info = cell(NPID*NROI*NSIDE, NFIELDS);
info(:,:) = {'unassigned'};
if (VERBOSE)
    disp('      vc# (MR)        p# (PET)              roi              side            moment           pop    mean    err');
    disp('----------------------------------------------------------------------------------------------------------------');    
end

for p = 1:NPID
    
    if (pidToExclude(p, kindImg)) 
        for r = 1:NROI
            for s = 1:NSIDE
                idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
                info(idx,:) = {'--'};
            end
        end
        continue; 
    end
    
    for r = 1:NROI
        for s = 1:NSIDE        
            idx = (p - 1)*NROI*NSIDE + (r - 1)*NSIDE + s;
            info(idx,1) = {pidList(p)};
            info(idx,2) = {hoFileList(p)};
            switch (r)
                case 1
                    info(idx,3) = {'grey'};
                case 2
                    info(idx,3) = {'basal'};
                case 3
                    info(idx,3) = {'white'};
                otherwise
                    info(idx,3) = {'unknown'};
            end
            switch (s)
                case 1
                    info(idx,4) = {'contra.'};
                case 2
                    info(idx,4) = {'ipsi.'};
            end 
            switch (moment)
                case 0
                    info(idx,5) = {'N'};
                case 1
                    info(idx,5) = {'mean'};
                case 2
                    info(idx,5) = {'stderr'};
                otherwise
                    info(idx,5) = {'unknown'};
            end
			if pops,
            	info(idx,6)  = {pops(idx,1)}; end
			if means,
				info(idx,7) = {means(idx,1)}; end
			if errs,
            	info(idx,8) = {errs(idx,1)}; end
			if BAratio,
            	info(idx,9) = {BAratio(idx,mlRefCbf_info_clean())}; end
        end
    end         
end

