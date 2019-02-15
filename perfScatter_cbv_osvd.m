function perfScatter_cbv(pt, hemisphere, concModel, intercept, slope)

disp('   ');
disp('   perfScatter_wrapper, version 8/10/2004');

perfParam = 'CBV';
deconvMethod = 'oSVD';

%---------------------
% spreadsheet header |
%---------------------
disp(['Parameters, Patient#, Intercept, Slope, s(Intercept), s(Slope),' ...
        ' DoF, c2/DoF, Q, Pearson R, Pearson Pr{R}, Spearman R, Spearman Pr{R}']);

%----------------------
% spreadsheet entries |
%----------------------
if strcmp(concModel, 'Cumulant')
    
    if (pt == 1)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(1, 'rhs', perfParam, deconvMethod, concModel, 0.25, 70, 971, intercept, slope);
        else
            perfScatter(1, 'lhs', perfParam, deconvMethod, concModel, 0.25, 8, ...
                555, intercept, slope); % 591 crashes
        end
    elseif (pt == 2)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(2, 'rhs', perfParam, deconvMethod, concModel, 0.35, 90, 1106, intercept, slope);
        else
            perfScatter(2, 'lhs', perfParam, deconvMethod, concModel, 0.4, 90, 765, intercept, slope);
        end
    elseif (pt == 3)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(3, 'rhs', perfParam, deconvMethod, concModel, 1, 10, 1185, intercept, slope);
        else
            perfScatter(3, 'lhs', perfParam, deconvMethod, concModel, 0.4, 9, 994, intercept, slope); 
        end
    elseif (pt == 4)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(4, 'rhs', perfParam, deconvMethod, concModel, 0.35, 55, ...
                1320, intercept, slope); % 1410 crashes
        else
            perfScatter(4, 'lhs', perfParam, deconvMethod, concModel, 0.35, 65, 400, intercept, slope);
        end % 1013 crashes
    elseif (pt == 5)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(5, 'rhs', perfParam, deconvMethod, concModel, 0.4, 70, 1154, intercept, slope);
        else
            perfScatter(5, 'lhs', perfParam, deconvMethod, concModel, 0.4, 70, 1134, intercept, slope);
        end
    elseif (pt == 6)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(6, 'rhs', perfParam, deconvMethod, concModel, 0.26, 75,...
                410, intercept, slope); % 1279 crashes
        else
            perfScatter(6, 'lhs', perfParam, deconvMethod, concModel, 0.26, 77,... ...
                390, intercept, slope); % 1357 crashes    
        end
    elseif (pt == 7)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(7, 'rhs', perfParam, deconvMethod, concModel, 0.2, 57, 1518, intercept, slope);
        else
            perfScatter(7, 'lhs', perfParam, deconvMethod, concModel, 0.18, 58, 925, intercept, slope);
        end
    end
    
else % Standard
    
    if (pt == 1)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(1, 'rhs', perfParam, deconvMethod, concModel, 0.25, 70, 971, intercept, slope);
        else
            perfScatter(1, 'lhs', perfParam, deconvMethod, concModel, 0.3, 8, ...
                555, intercept, slope); % 591 crashes
        end
    elseif (pt == 2)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(2, 'rhs', perfParam, deconvMethod, concModel, 0.35, 90, 1106, intercept, slope);
        else
            perfScatter(2, 'lhs', perfParam, deconvMethod, concModel, 0.4, 90, 765, intercept, slope);
        end
    elseif (pt == 3)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(3, 'rhs', perfParam, deconvMethod, concModel, 1, 10, 1185, intercept, slope);
        else
            perfScatter(3, 'lhs', perfParam, deconvMethod, concModel, 0.45, 9, 994, intercept, slope); 
        end
    elseif (pt == 4)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(4, 'rhs', perfParam, deconvMethod, concModel, 0.35, 55, ...
                1320, intercept, slope); % 1410 crashes
        else
            perfScatter(4, 'lhs', perfParam, deconvMethod, concModel, 0.35, 65, 400, intercept, slope);
        end % 1013 crashes
    elseif (pt == 5)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(5, 'rhs', perfParam, deconvMethod, concModel, 0.4, 70, 1154, intercept, slope);
        else
            perfScatter(5, 'lhs', perfParam, deconvMethod, concModel, 0.4, 70, 1134, intercept, slope);
        end
    elseif (pt == 6)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(6, 'rhs', perfParam, deconvMethod, concModel, 0.26, 75,...
                410, intercept, slope); % 1279 crashes
        else
            perfScatter(6, 'lhs', perfParam, deconvMethod, concModel, 0.26, 77,... ...
                390, intercept, slope); % 1357 crashes    
        end
    elseif (pt == 7)
        if (strcmp(hemisphere, 'rhs'))
            perfScatter(7, 'rhs', perfParam, deconvMethod, concModel, 0.2, 57, 1518, intercept, slope);
        else
            perfScatter(7, 'lhs', perfParam, deconvMethod, concModel, 0.18, 58, 925, intercept, slope);
        end
    end
    
end


