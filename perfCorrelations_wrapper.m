function perfCorrelations_wrapper()

    % spreadsheet header
    disp(['Parameters, Patient#, Intercept, Slope, s(Intercept), s(Slope),' ...
	  ' DoF, c2/DoF, Q, Pearson R, Pearson Pr{R}, Spearman R, Spearman Pr{R}']);

    % spreadsheet entries
    perfCorrelations(1, 'ML-EM', 'rhs', 'Cumulant', 'CBF', 'HOM', 971);
    perfCorrelations(1, 'ML-EM', 'lhs', 'Cumulant', 'CBF', 'HOM', ...
    555); % 591 crashes
    perfCorrelations(2, 'ML-EM', 'rhs', 'Cumulant', 'CBF', 'HOM', 1106);
    perfCorrelations(2, 'ML-EM', 'lhs', 'Cumulant', 'CBF', 'HOM', 765);
    perfCorrelations(3, 'ML-EM', 'rhs', 'Cumulant', 'CBF', 'HOM', 1185);
    perfCorrelations(3, 'ML-EM', 'lhs', 'Cumulant', 'CBF', 'HOM', 994); 
    perfCorrelations(4, 'ML-EM', 'rhs', 'Cumulant', 'CBF', 'HOM', ...
    1320); % 1410 crashes
    perfCorrelations(4, 'ML-EM', 'lhs', 'Cumulant', 'CBF', 'HOM', 1013);
    perfCorrelations(5, 'ML-EM', 'rhs', 'Cumulant', 'CBF', 'HOM', 1154);
    perfCorrelations(5, 'ML-EM', 'lhs', 'Cumulant', 'CBF', 'HOM', 1134);
    perfCorrelations(6, 'ML-EM', 'rhs', 'Cumulant', 'CBF', 'HOM',...
    410); % 1279 crashes
    perfCorrelations(6, 'ML-EM', 'lhs', 'Cumulant', 'CBF', 'HOM',... ...
    390); % 1357 crashes    
    perfCorrelations(7, 'ML-EM', 'rhs', 'Cumulant', 'CBF', 'HOM', 1518);
    perfCorrelations(7, 'ML-EM', 'lhs', 'Cumulant', 'CBF', 'HOM', 925);
    
    
    perfCorrelations(1, 'ML-EM', 'rhs', 'LIN', 'CBF', 'HOM', 971);
    perfCorrelations(1, 'ML-EM', 'lhs', 'LIN', 'CBF', 'HOM', ...
    555); % 591 crashes
    perfCorrelations(2, 'ML-EM', 'rhs', 'LIN', 'CBF', 'HOM', 1106);
    perfCorrelations(2, 'ML-EM', 'lhs', 'LIN', 'CBF', 'HOM', 765);
    perfCorrelations(3, 'ML-EM', 'rhs', 'LIN', 'CBF', 'HOM', 1185);
    perfCorrelations(3, 'ML-EM', 'lhs', 'LIN', 'CBF', 'HOM', 994); 
    perfCorrelations(4, 'ML-EM', 'rhs', 'LIN', 'CBF', 'HOM', ...
    1320); % 1410 crashes
    perfCorrelations(4, 'ML-EM', 'lhs', 'LIN', 'CBF', 'HOM', 1013);
    perfCorrelations(5, 'ML-EM', 'rhs', 'LIN', 'CBF', 'HOM', 1154);
    perfCorrelations(5, 'ML-EM', 'lhs', 'LIN', 'CBF', 'HOM', 1134);
    perfCorrelations(6, 'ML-EM', 'rhs', 'LIN', 'CBF', 'HOM',...
    410); % 1279 crashes
    perfCorrelations(6, 'ML-EM', 'lhs', 'LIN', 'CBF', 'HOM',... ...
    390); % 1357 crashes    
    perfCorrelations(7, 'ML-EM', 'rhs', 'LIN', 'CBF', 'HOM', 1518);
    perfCorrelations(7, 'ML-EM', 'lhs', 'LIN', 'CBF', 'HOM', 925);
    

    perfCorrelations(1, 'ML-EM', 'rhs', 'Cumulant', 'cbv', 'com', 920); ...
    % 971 crashes
    perfCorrelations(1, 'ML-EM', 'lhs', 'Cumulant', 'cbv', 'com', ...
    555); % 591 crashes
    perfCorrelations(2, 'ML-EM', 'rhs', 'Cumulant', 'cbv', 'com', ...
			       430); % 1106 crashes
    perfCorrelations(2, 'ML-EM', 'lhs', 'Cumulant', 'cbv', 'com', 765);
    perfCorrelations(3, 'ML-EM', 'rhs', 'Cumulant', 'cbv', 'com', 1185);
    perfCorrelations(3, 'ML-EM', 'lhs', 'Cumulant', 'cbv', 'com', 994); 
    perfCorrelations(4, 'ML-EM', 'rhs', 'Cumulant', 'cbv', 'com', ...
    1320); % 1410 crashes
    perfCorrelations(4, 'ML-EM', 'lhs', 'Cumulant', 'cbv', 'com', 1013);
    perfCorrelations(5, 'ML-EM', 'rhs', 'Cumulant', 'cbv', 'com', 1154);
    perfCorrelations(5, 'ML-EM', 'lhs', 'Cumulant', 'cbv', 'com', 1134);
    perfCorrelations(6, 'ML-EM', 'rhs', 'Cumulant', 'cbv', 'com',...
    410); % 1279 crashes
    perfCorrelations(6, 'ML-EM', 'lhs', 'Cumulant', 'cbv', 'com',... ...
    390); % 1357 crashes    
    perfCorrelations(7, 'ML-EM', 'rhs', 'Cumulant', 'cbv', 'com', 1518);
    perfCorrelations(7, 'ML-EM', 'lhs', 'Cumulant', 'cbv', 'com', 925);
    
    
    perfCorrelations(1, 'ML-EM', 'rhs', 'LIN', 'cbv', 'com', 971);
    perfCorrelations(1, 'ML-EM', 'lhs', 'LIN', 'cbv', 'com', ...
    555); % 591 crashes
    perfCorrelations(2, 'ML-EM', 'rhs', 'LIN', 'cbv', 'com', 1106);
    perfCorrelations(2, 'ML-EM', 'lhs', 'LIN', 'cbv', 'com', 765);
    perfCorrelations(3, 'ML-EM', 'rhs', 'LIN', 'cbv', 'com', 1185);
    perfCorrelations(3, 'ML-EM', 'lhs', 'LIN', 'cbv', 'com', 994); 
    perfCorrelations(4, 'ML-EM', 'rhs', 'LIN', 'cbv', 'com', ...
    1320); % 1410 crashes
    perfCorrelations(4, 'ML-EM', 'lhs', 'LIN', 'cbv', 'com', 1013);
    perfCorrelations(5, 'ML-EM', 'rhs', 'LIN', 'cbv', 'com', 1154);
    perfCorrelations(5, 'ML-EM', 'lhs', 'LIN', 'cbv', 'com', 1134);
    perfCorrelations(6, 'ML-EM', 'rhs', 'LIN', 'cbv', 'com',...
    410); % 1279 crashes
    perfCorrelations(6, 'ML-EM', 'lhs', 'LIN', 'cbv', 'com',... ...
    390); % 1357 crashes    
    perfCorrelations(7, 'ML-EM', 'rhs', 'LIN', 'cbv', 'com', 1518);
    perfCorrelations(7, 'ML-EM', 'lhs', 'LIN', 'cbv', 'com', 925);

    
    
    
    
    
    
    
    
    
    
    
    
     perfCorrelations(1, 'osvd', 'rhs', 'Cumulant', 'CBF', 'HOM', ...
				420); % 971 crashes
     perfCorrelations(1, 'osvd', 'lhs', 'Cumulant', 'CBF', 'HOM', ...
     555); % 591 crashes
     perfCorrelations(2, 'osvd', 'rhs', 'Cumulant', 'CBF', 'HOM', 1106);
     perfCorrelations(2, 'osvd', 'lhs', 'Cumulant', 'CBF', 'HOM', 765);
     perfCorrelations(3, 'osvd', 'rhs', 'Cumulant', 'CBF', 'HOM', 1185);
     perfCorrelations(3, 'osvd', 'lhs', 'Cumulant', 'CBF', 'HOM', 994); 
     perfCorrelations(4, 'osvd', 'rhs', 'Cumulant', 'CBF', 'HOM', ...
     750); % 1410 crashes
     perfCorrelations(4, 'osvd', 'lhs', 'Cumulant', 'CBF', 'HOM', ...
				550); % 1013 crashes
     perfCorrelations(5, 'osvd', 'rhs', 'Cumulant', 'CBF', 'HOM', 1154);
     perfCorrelations(5, 'osvd', 'lhs', 'Cumulant', 'CBF', 'HOM', 1134);
     perfCorrelations(6, 'osvd', 'rhs', 'Cumulant', 'CBF', 'HOM',...
     410); % 1279 crashes
     perfCorrelations(6, 'osvd', 'lhs', 'Cumulant', 'CBF', 'HOM',... ...
     390); % 1357 crashes    
     perfCorrelations(7, 'osvd', 'rhs', 'Cumulant', 'CBF', 'HOM', 1518);
     perfCorrelations(7, 'osvd', 'lhs', 'Cumulant', 'CBF', 'HOM', ...
     270); % 925 crashes
    
    
     perfCorrelations(1, 'osvd', 'rhs', 'LIN', 'CBF', 'HOM', 971);
     perfCorrelations(1, 'osvd', 'lhs', 'LIN', 'CBF', 'HOM', ...
     555); % 591 crashes
     perfCorrelations(2, 'osvd', 'rhs', 'LIN', 'CBF', 'HOM', 1106);
     perfCorrelations(2, 'osvd', 'lhs', 'LIN', 'CBF', 'HOM', 765);
     perfCorrelations(3, 'osvd', 'rhs', 'LIN', 'CBF', 'HOM', 1185);
     perfCorrelations(3, 'osvd', 'lhs', 'LIN', 'CBF', 'HOM', 994); 
     perfCorrelations(4, 'osvd', 'rhs', 'LIN', 'CBF', 'HOM', ...
     1320); % 1410 crashes
     perfCorrelations(4, 'osvd', 'lhs', 'LIN', 'CBF', 'HOM', 1013);
     perfCorrelations(5, 'osvd', 'rhs', 'LIN', 'CBF', 'HOM', 1154);
     perfCorrelations(5, 'osvd', 'lhs', 'LIN', 'CBF', 'HOM', 1134);
     perfCorrelations(6, 'osvd', 'rhs', 'LIN', 'CBF', 'HOM',...
     410); % 1279 crashes
     perfCorrelations(6, 'osvd', 'lhs', 'LIN', 'CBF', 'HOM',... ...
     390); % 1357 crashes    
     perfCorrelations(7, 'osvd', 'rhs', 'LIN', 'CBF', 'HOM', 1518);
     perfCorrelations(7, 'osvd', 'lhs', 'LIN', 'CBF', 'HOM', 925);
    

     perfCorrelations(1, 'osvd', 'rhs', 'Cumulant', 'cbv', 'com', 410); ...
     % 971 crashes
     perfCorrelations(1, 'osvd', 'lhs', 'Cumulant', 'cbv', 'com', ...
     555); % 591 crashes
     perfCorrelations(2, 'osvd', 'rhs', 'Cumulant', 'cbv', 'com', ...
 			       430); % 1106 crashes
     perfCorrelations(2, 'osvd', 'lhs', 'Cumulant', 'cbv', 'com', 765);
     perfCorrelations(3, 'osvd', 'rhs', 'Cumulant', 'cbv', 'com', 1185);
     perfCorrelations(3, 'osvd', 'lhs', 'Cumulant', 'cbv', 'com', 994); 
     perfCorrelations(4, 'osvd', 'rhs', 'Cumulant', 'cbv', 'com', ...
     370); % 1410 crashes
     perfCorrelations(4, 'osvd', 'lhs', 'Cumulant', 'cbv', 'com', ...
				390); % 1013 crashes
     perfCorrelations(5, 'osvd', 'rhs', 'Cumulant', 'cbv', 'com', 1154);
     perfCorrelations(5, 'osvd', 'lhs', 'Cumulant', 'cbv', 'com', ...
				280); % 1134 crashes
     perfCorrelations(6, 'osvd', 'rhs', 'Cumulant', 'cbv', 'com',...
     410); % 1279 crashes
     perfCorrelations(6, 'osvd', 'lhs', 'Cumulant', 'cbv', 'com',... ...
     370); % 1357 crashes    
     perfCorrelations(7, 'osvd', 'rhs', 'Cumulant', 'cbv', 'com', 1518);
     perfCorrelations(7, 'osvd', 'lhs', 'Cumulant', 'cbv', 'com', ...
				590); % 925 crashes
    
    
     perfCorrelations(1, 'osvd', 'rhs', 'Standard', 'cbv', 'com', 971);
     perfCorrelations(1, 'osvd', 'lhs', 'Standard', 'cbv', 'com', ...
     555); % 591 crashes
     perfCorrelations(2, 'osvd', 'rhs', 'Standard', 'cbv', 'com', 1106);
     perfCorrelations(2, 'osvd', 'lhs', 'Standard', 'cbv', 'com', 765);
     perfCorrelations(3, 'osvd', 'rhs', 'Standard', 'cbv', 'com', 1185);
     perfCorrelations(3, 'osvd', 'lhs', 'Standard', 'cbv', 'com', 994); 
     perfCorrelations(4, 'osvd', 'rhs', 'Standard', 'cbv', 'com', ...
     1320); % 1410 crashes
     perfCorrelations(4, 'osvd', 'lhs', 'Standard', 'cbv', 'com', 1013);
     perfCorrelations(5, 'osvd', 'rhs', 'Standard', 'cbv', 'com', 1154);
     perfCorrelations(5, 'osvd', 'lhs', 'Standard', 'cbv', 'com', 1134);
     perfCorrelations(6, 'osvd', 'rhs', 'Standard', 'cbv', 'com',...
     410); % 1279 crashes
     perfCorrelations(6, 'osvd', 'lhs', 'Standard', 'cbv', 'com',... ...
     390); % 1357 crashes    
     perfCorrelations(7, 'osvd', 'rhs', 'Standard', 'cbv', 'com', 1518);
     perfCorrelations(7, 'osvd', 'lhs', 'Standard', 'cbv', 'com', 925);
    
    
