
function stem = filestemQ(pid, metric)
	
	switch (nargin)
		case 2
			[pid p] = ensurePid(pid);
		otherwise
			error(help('filestemQ'));
	end

    [pid, p] = ensurePid(pid);
    
    switch(metric)
        case 'cbf'
            stem = 'qCBF_DSC';
        case 'cbv'
            stem = 'qCBV_DSC';
        case 'mtt'
            stem = 'qMTT_DSC';
        otherwise
            error(['filestemQ did not recognize metric ' metric]);
    end
  
