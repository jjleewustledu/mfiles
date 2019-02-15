%
%  USAGE:  folder = pidFolder(pid)
%
%          pid:      string
%          folder:   name of containing folder
%
%________________________________________________________________________

function folder = pidFolder(pid)

    if (strcmp('vc', pid(1:2)))
        folder = pid;
        return
    end
    
    switch (pid)
        case 'p7118'
            folder = [wuid(1) pid '_2007oct16'];
        case 'p7146'
            folder = [wuid(3) pid '_2008jan4'];
        case 'p7153'
            folder = [wuid(2) pid '_2008jan16'];
        case 'p7189'
            folder = [wuid(5) pid '_2008mar12'];
        case 'p7191'
            folder = [wuid(6) pid '_2008mar13'];
        case 'p7194'
            folder = [wuid(7) pid '_2008mar14'];
        case 'p7216'
            folder = [wuid(8) pid '_2008apr11'];
        case 'p7217'
            folder = [wuid(9) pid '_2008apr14'];
        case 'p7219'
            folder = [wuid(10) pid '_2008apr23'];
        case 'p7229'
            folder = [wuid(11) pid '_2008apr28'];
        case 'p7230'
            folder = [wuid(12) pid '_2008apr29'];
        case 'p7243'
            folder = [wuid(14) pid '_2008may21'];
		case 'p7248'
			folder = [wuid(15) pid '_2008may23'];
		case 'p7257'
			folder = [wuid(16) pid '_2008jun4'];
		case 'p7260'
			folder = [wuid(17) pid '_2008jun9'];
		case 'p7266'
			folder = [wuid(18) pid '_2008jun16'];
		case 'p7267'
			folder = [wuid(19) pid '_2008jun16'];
		case 'p7270'
			folder = [wuid(21) pid '_2008jun18'];
		case 'p7321'
			folder = [wuid(24) pid '_2008sep8'];
		case 'p7335'
			folder = [wuid(26) pid '_2008oct21'];
		case 'p7336'
			folder = [wuid(27) pid '_2008oct21'];
		case 'p7338'
			folder = [wuid(28) pid '_2008oct30'];
		case 'p7365'
			folder = [wuid(30) pid '_2009jan6'];
        otherwise
            error(['pidFolder:  could not recognize pid -> ' pid]);
    end
   
    function str = wuid(idx)
		if (1 <= idx && idx <= 9) 
			str = ['wu00' num2str(idx) '_'];
		elseif (10 <= idx && idx <= 99)
			str = ['wu0'  num2str(idx) '_'];
        else
	        error('mfiles:InputParamsErr', ['pidFolder.wuid does not recognize idx -> ' idx]);
	    end
	end 
end


