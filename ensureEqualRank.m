%% ENSUREEQUALRANK
%  Usage: boo = ensureEqualRank(arr1, arr2, throwe)
%         boo, throwe are boolean
%         arr1, arr2 are Matlab-native arrays
function  boo = ensureEqualRank(arr1, arr2, throwe)

    if(~all(size(arr1) == size(arr2)))
        boo  = false;
        mess = ['ensureEqualRank:  size(srr1) -> ' num2str(size(arr1)) ...
                             ' but size(arr2) -> ' num2str(size(arr2))];
        disp(mess);
        if (throwe)
            ME = MException('mlfourd:ArraySizeMismatch', mess);
            throw(ME);
        end
    else
        boo = true;
    end
end