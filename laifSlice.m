
function slice = laifSlice(pid, sliceCard)

    [pid p] = ensurePid(pid);
    
    switch (sliceCard)
        case 1
            slice = bayesSlice1(p);
        case 2
            slice = bayesSlice2(p);
        otherwise
            error('laifSlice supports only cardinal slices 1, 2');
    end
            
            
