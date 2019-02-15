function perfCorrelations_validate(Nrand)
    
    disp(['Patient#, Pearson R, Spearman bigD, Spearman zD, Spearman probD, ' ...
	  'Spearman Rs, Spearman probRs, FitLine a, FitLine b, ' ...
	  'FitLine sigmaA, FitLine sigmaB, FitLine chisq/dof, FitLine q' ...
	 ]);
    disp(' ');

    disp('   ___________________________');
    disp('   Validation:  no correlation');
    disp('   ___________________________');
    mrperfVal = rand(Nrand, 1);
    petperfVal = rand(Nrand, 1);
    disp('   calling Correlations2');
    Correlations2(mrperfVal', petperfVal', Nrand, false);
    disp(' ');
    figure(1)
    scatter(petperfVal, mrperfVal, 1, '.k');

    disp('   _________________________________');
    disp('   Validation:  complete correlation');
    disp('   _________________________________');
    petperfVal = rand(Nrand, 1);
    mrperfVal = petperfVal;
    disp('   calling Correlations2');
    Correlations2(mrperfVal', petperfVal', Nrand, false);  
    disp(' ');
    figure(2)
    scatter(petperfVal, mrperfVal, 1, '.k');

    disp('   ______________________________________');
    disp('   Validation:  complete anti-correlation');
    disp('   ______________________________________');
    petperfVal = rand(Nrand, 1);
    mrperfVal = 1.0-petperfVal;
    disp('   calling Correlations2');
    Correlations2(mrperfVal', petperfVal', Nrand, true);  
    disp(' ');
    figure(3)
    scatter(petperfVal, mrperfVal, 1, '.k');
  
