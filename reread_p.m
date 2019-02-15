function p = reread_p(pids, p)

for k = 1:length(pids)
    p = resnippet(pids{k}, p);
end

    function p = resnippet(pid, p, docbv)
        
        assert(nargin > 0);
        import mlfourd.* mlfsl.*;
        disp(['starting resnippet on ' pid '....................................................']);
        if (nargin < 3); docbv = true; end
        pipe    = mlpipe.PipelineRegistry.instance;
        imaging = mlfsl.ImagingComponent(pid);
        pipe.debugging = false;
        
        
        
        % PARENCHYMA/FG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        cd(imaging.roiPath); pwd; %#ok<*MCCD>
        parenchyma = NIfTI.load('parenchyma_xr3d.nii.gz');        
        [hh,dd] = reviewimg(parenchyma, 'existing parenchyma_xr3d');
        p.(pid).parenchyma = parenchyma;
        
        
        
        % T1 & T2 STRUCTURAL IMAGING %%%%%%%%%%%%%%%%%%%
        t1 = NIfTI.load('t1_mpr_xr3d.nii.gz');
        p.(pid).t1 = t1;
        t2 = NIfTI.load('t2_on_t1.nii.gz');
        p.(pid).t2 = t2;
        try
            ir = NIfTI.load('ir_on_t1.nii.gz');
            p.(pid).ir = ir;
        catch ME
            disp('did not find IR series');
        end
        
        
        
        % PET & MR PERFUSION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ho          = mlpet.PETBuilder.PETfactory(imaging.pid, 'ho', [0 0 0], [1 1 1]);
        p.(pid).ho = ho;
        pcbf_101010 = mlpet.PETBuilder.PETfactory(imaging.pid, 'cbf', [10 10 10], [1 1 1]);
        p.(pid).pcbf_101010 = pcbf_101010;
        qcbf_101010 = MRIBuilder.MRfactory(imaging.pid, 'qcbf', [10 10 10], [1 1 1]);
        p.(pid).qcbf_101010 = qcbf_101010;
        if (docbv)
            oc          = mlpet.PETBuilder.PETfactory(imaging.pid, 'oc', [0 0 0], [1 1 1]);
            p.(pid).oc = oc;
            pcbv_101010 = mlpet.PETBuilder.PETfactory(imaging.pid, 'cbv', [10 10 10], [1 1 1]);
            p.(pid).pcbv_101010 = pcbv_101010;
            qcbv_101010 = MRIBuilder.MRfactory(imaging.pid, 'qcbv', [10 10 10], [1 1 1]);
            p.(pid).qcbv_101010 = qcbv_101010;
        end
        while (~isfield(p.(pid), 'sliceidx'))
            p.(pid).sliceidx = input('please select a slice index for figures (matlab indexing): ');
        end
        p = reindex_p({pid}, p);      
    end % resnippet
end % reread_p
