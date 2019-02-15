classdef MyTestCase < MyTestCase_R2013a
    %% MYTESTCASE provides testing objects for convenience and modularity
    
    properties (Dependent)
        adc_fqfn
        adc_fp
        adcCntxt
        bettedPath
        bt1_fqfn
        bt1_fp
        bt1Cntxt
        dataPath
        dwi_fqfn
        dwi_fp
        dwiCntxt
        ep2d_fqfn
        ep2d_fp
        ep2dCntxt
        ep2dMcf_fqfn
        ep2dMcfCntxt
        ep2dMean_fqfn
        ep2dMeanCntxt
        fslPath
        ho_fqfn
        ho_fp
        ir_fqfn
        ir_fp
        irCntxt
        mrPath
        oc_fp
        oc_fqfn
        oo_fp
        oo_fqfn
        petPath
        preferredSession
        preferredTarg
        rawavg_fqfn
        rawavgfp
        rawavgCntxt
        reference
        sessionPath
        showViewers
        studyPath
        t1_fqfn
        t1_fp
        t1Cntxt
        t1mask_fqfn
        t1maskfp
        t1MaskCntxt
        t2_fqfn
        t2_fp
        t2Cntxt
        targPath
        testPath
        tr_fqfn
        tr_fp
    end
    
    methods %% set/get
        function fn  = get.adc_fqfn(this)
            fn = this.fqfilenameInFsl(this.adc_fp);
        end
        function fp  = get.adc_fp(this) %#ok<MANU>
            fp = 'adc_default';          
        end
        function ic  = get.adcCntxt(this)
            ic = mlfourd.ImagingContext.load(this.adc_fqfn);
        end
        function pth = get.bettedPath(this)
            pth = fullfile(this.fslPath, 'bet', '');
        end
        function fn  = get.bt1_fqfn(this)
            fn = this.fqfilenameInFsl(this.bt1_fp);
        end
        function fp  = get.bt1_fp(this) %#ok<MANU>
            fp = 'bt1_default_restore';
        end 
        function ic  = get.bt1Cntxt(this)
            ic = mlfourd.ImagingContext.load(this.bt1_fqfn);
        end
        function pth = get.dataPath(this)
            pth = fullfile(this.sessionPath, 'Trio', 'CDR_OFFLINE', '');
        end
        function fn  = get.dwi_fqfn(this)
            fn = this.fqfilenameInFsl(this.dwi_fp);
        end
        function fp  = get.dwi_fp(this) %#ok<MANU>
            fp = 'dwi_default';
        end
        function ic  = get.dwiCntxt(this)
            ic = mlfourd.ImagingContext.load(this.dwi_fqfn);
        end
        function fp  = get.ep2d_fp(this)
            switch (this.preferredSession)
                case 1
                    fp = 'ep2d_009';
                otherwise
                    fp = 'ep2d_default';
            end
        end   
        function fn  = get.ep2d_fqfn(this)
            fn = this.fqfilenameInFsl(this.ep2d_fp);
        end 
        function fn  = get.ep2dMcf_fqfn(this)
            fn = fullfile(this.fslPath, 'ep2d_017_mcf.nii.gz');
            if (~lexist(fn, 'file'))
                this.createEp2dMean; end
        end
        function ic  = get.ep2dCntxt(this)
            ic = mlfourd.ImagingContext.load(this.ep2d_fqfn);
        end
        function ic  = get.ep2dMcfCntxt(this)
            ic = mlfourd.ImagingContext.load(this.ep2dMcf_fqfn);
        end
        function fn  = get.ep2dMean_fqfn(this)
            fn = fullfile(this.fslPath, 'ep2d_017_mcf_meanvol.nii.gz');
            if (~lexist(fn, 'file'))
                this.createEp2dMean; end
        end
        function ic  = get.ep2dMeanCntxt(this)
            ic = mlfourd.ImagingContext.load(this.ep2dMean_fqfn);
        end
        function pth = get.fslPath(this)
            pth = fullfile(this.sessionPath, mlfsl.FslRegistry.instance.fslFolder, '');
        end  
        function fn  = get.ho_fqfn(this)
            fn = this.fqfilenameInFsl(this.ho_fp);
        end
        function fp  = get.ho_fp(this) %#ok<MANU>
            fp = 'ho_meanvol_default';
        end 
        function fn  = get.ir_fqfn(this)
            fn = this.fqfilenameInFsl(this.ir_fp);
        end
        function fp  = get.ir_fp(this)
            switch (this.preferredSession)
                case 1
                    fp = 'ir_default';
                otherwise
                    fp = 't2_default';
            end
        end 
        function ic  = get.irCntxt(this)
            ic = mlfourd.ImagingContext.load(this.ir_fqfn);
        end
        function pth = get.mrPath(this)
            pth = fullfile(fullfile(this.sessionPath, 'Trio'));
            assertExistDir(@this.get.mrPath, pth);
        end
        function fn  = get.oc_fqfn(this)
            fn = this.fqfilenameInFsl(this.oc_fp);
        end
        function fp  = get.oc_fp(this) %#ok<MANU>
            fp = 'poc';
        end  
        function fn  = get.oo_fqfn(this)
            fn = this.fqfilenameInFsl(this.oo_fp);
        end
        function fp  = get.oo_fp(this) %#ok<MANU>
            fp = 'oo_meanvol_default';
        end 
        function pth = get.petPath(this) 
            pth = fullfile(fullfile(this.sessionPath, 'ECAT_EXACT'));
            assert(lexist(pth, 'dir'));
        end
        function this    = set.preferredSession(this, s)
            this.preferredSession_ = s;
        end
        function s       = get.preferredSession(this)
            s = this.preferredSession_;
        end
        function trg = get.preferredTarg(this)
            switch (this.preferredSession)
                case 1
                    trg = this.targPaths_{1};
                otherwise
                    trg = this.targPaths_{4};
            end
        end  
        function fp  = get.rawavgfp(this) %#ok<MANU>
            fp = 'rawavg';
        end
        function fn  = get.rawavg_fqfn(this)
            fn = fullfile(this.sessionPath, 'mri', [this.rawavgfp '.mgz']);
        end
        function ic  = get.rawavgCntxt(this)
            ic = mlfourd.ImagingContext.load(this.rawavg_fqfn);
        end
        function ref = get.reference(this)
            ref = this.fqfilenameInFsl(this.t1_fp);
        end    
        function pth = get.studyPath(this)
            pth = fullfile(this.testPath, 'np755', '');
            assert(lexist(pth, 'dir'));
        end
        function pth = get.sessionPath(this)
            if (~isempty(this.sessionPath_))
                pth = this.sessionPath_; return; end
            pth = this.sessionPaths_{this.preferredSession};
            assert(lexist(pth, 'dir'));
        end
        function s   = get.showViewers(this) %#ok<MANU>
            s = true;
        end
        function pth = get.targPath(this)
            pth = fullfile(this.sessionPath, 'Trio', 'unpack', '');
        end
        function pth = get.testPath(this)
            if (isempty(this.testPath_))
                this.testPath_ = fullfile(getenv('MLUNIT_TEST_PATH'), ''); 
            end
            pth = this.testPath_;
        end     
        function fn  = get.t1_fqfn(this)
            fn = this.fqfilenameInFsl(this.t1_fp);
        end
        function fp  = get.t1_fp(this) %#ok<MANU>
            fp = 't1_default';
        end 
        function ic  = get.t1Cntxt(this)
            ic = mlfourd.ImagingContext.load(this.t1_fqfn);
        end
        function fn  = get.t1mask_fqfn(this)
            fn = this.fqfilenameInFsl(this.t1maskfp);
        end        
        function fp  = get.t1maskfp(this)
            fp = ['b' this.t1_fp '_mask'];
        end
        function ic  = get.t1MaskCntxt(this)
            ic = mlfourd.ImagingContext.load(this.t1mask_fqfn);
        end
        function fn  = get.t2_fqfn(this)
            fn = this.fqfilenameInFsl(this.t2_fp);
        end    
        function fp  = get.t2_fp(this) %#ok<MANU>
            fp = 't2_default';
        end 
        function ic  = get.t2Cntxt(this)
            ic = mlfourd.ImagingContext.load(this.t2_fqfn);
        end
        function fp  = get.tr_fp(this) %#ok<MANU>
            fp = 'ptr';
        end 
        function fn  = get.tr_fqfn(this)
            fn = this.fqfilenameInFsl(this.tr_fp);
        end
    end
    
    methods
        function fqff = fqfilenameInFsl(this, name)
            if (iscell(name)) %% use only the first cell
                fqff = this.fqfilenamesInFsl(name{1}); return; end
            assert(ischar(name));
            fqff = fullfilename(this.fslPath, name);
        end
        function fns  = fqfilenamesInFsl(this, files)
            files = ensureCell(files);
            fns   = cellfun(@this.fqfilenameInFsl, files, 'UniformOutput', false);
        end
    end
    
    methods (Static)
        function       assertEntropies(es, objs)
            es   = ensureCell(es);
            objs = ensureCell(objs);
            for o = 1:min(length(es), length(objs))
                try
                    nii = imcast(objs{o}, 'mlfourd.NIfTI');
                    assertElementsAlmostEqual(single(es{o}), nii.entropy);
                catch ME
                    handexcept(ME);
                end
            end
        end   
        function       assertKLdiv(expected, fn0, fn)
            import mlfsl_xunit.*;
            assertVectorsAlmostEqual( ...
                expected, ...
                single(Test_mlfsl.filenames2KL(fn0, fn)));
        end   
        function       assertObjectsEqual(o, o2)
            if (isa(o, 'mlfourd.ImagingArrayList'))
                assertImagingArrayListsEqual(o, ...
                    imcast(o2, class(o))); 
                return
            end
            assertTrue(all(isequal(o, o2)));
        end
        function       assertImagingArrayListsEqual(ial, ial2)
            assertEqual(ial.length, ial2.length);
            for a = 1:ial.length
                MyTestCase.assertObjectsEqual(ial.get(a), ial2.get(a));
            end
        end
        function       assertStringsEqual(s, s2)
            s  = ensureString(s);
            s2 = ensureString(s2);
            assertEqual(s, s2);
        end
        function       printAndAssertEqual(v, v2)
            v  = ensureString(v);
            v2 = ensureString(v2);
            if (length(v) > MyTestCase.SCREEN_WIDTH/2 || length(v2) > MyTestCase.SCREEN_WIDTH/2)
                fprintf('\n1st input: \n\t%s \n2nd input: \n\t%s \n\n', v, v2);
            else
                fprintf('\n1st input:  %s; 2nd input:  %s\n\n', v, v2);
            end
            assertEqual(v, v2);
        end
        function       printExpectedFound(label, expect, found)
            switch (class(found))
                case {'class' 'struct'}
                    frmt = '%s\n';
                    expect = struct2str(expect);
                    found  = struct2str(found);
                case  'cell'
                    frmt = '%s\n';
                    expect = cell2str(expect);
                    found  = cell2str(found);
                case  'char'
                    frmt = '%s\n';
                otherwise
                    if (isnumeric(found))
                        frmt = '%18.16g';
                    else
                        error('mfiles:UnsupportedType', 'class(found)->%s', class(found));
                    end
            end
            fprintf(['Parameter %s was expected to be:\n' frmt '\n\nbut was found to be:\n' frmt '\n\n'], ...
                      label, expect, found);
            fprintf( '................................................................................\n\n');
        end
        function es  = dispEntropies(fns)
            fns = ensureCell(fns);
            es  = ensureCell( ...
                  MyTestCase.filenames2entropies(fns));
            for e = 1:length(es)
                fprintf('entropy(%s) -> %18.16g\n', fns{e}, es{e});
            end
        end
        function es  = filenames2entropies(fns)
            fns = ensureCell(fns);
            es  = cell(1, length(fns));
            for f = 1:length(fns)
                es{f} = mlfourd.NIfTI.load(fns{f});
                es{f} = es{f}.entropy;
            end
        end             
        function kld = filenames2KL(fn0, fn)
            import mlfourd.* mlentropy.*;
            assertExistFile(@MyTestCase.filenames2KL, filename(fn0));
            assertExistFile(@MyTestCase.filenames2KL, filename(fn));
            kl  = KL(NIfTI.load(fn0), NIfTI.load(fn));
            kld = kl.kldivergence;
            if (isnan(kld))
                kld = kl.H; % KLUDGE
            end
        end
        function klh = filenames2KLH(fn)
            import mlfourd.* mlentropy.*;
            assertExistFile(@MyTestCase.filenames2KLH, filename(fn));
            kl  = KL(NIfTI.load(fn));
            klh = kl.H_p;
        end 
    end
    
    %% PROTECTED
        
    methods (Access = 'protected')
        function this = MyTestCase(varargin)
 			this = this@MyTestCase_R2013b(varargin{:});
            if (isempty(this.sessionPaths_))
                this.sessionPaths_ = { fullfile(this.studyPath, 'mm05-001_p7936_2011nov18', '') ...
                                       fullfile(this.studyPath, 'mm01-020_p7377_2009feb5',  '') };
            end
            cd(this.sessionPaths_{this.preferredSession});            
        end
    end
    
    %% PRIVATE
    
    properties (Constant, Access = 'private')
        SCREEN_WIDTH = 120;
    end
    
    properties (Access = 'private')
        preferredSession_ = 2;
        sessionPath_ %% assign to override this.sessionPaths_{this.preferredSession}
        sessionPaths_
        testPath_
    end
    
end

