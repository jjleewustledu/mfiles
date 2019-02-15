
function writeBayes4dfp(pid, param)

    if (~strcmp('cbf', param) && ~strcmp('F', param))
        error('oops...   writeBayes4dfp supports only cbf or F at present'); end
    [pid p] = ensurePid(pid);
    img = dip_image(peekPerfusion(pid, 'F'))
    cd([peekDrive '/perfusion/vc/' pid '/Bayes' ]);
    write4d(img, 'float', 'ieee-be', 'F.0001.mean.4dfp.img');
    
