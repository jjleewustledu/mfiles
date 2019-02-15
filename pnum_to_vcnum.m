
function vcnum = pnum_to_vcnum(pnum)

    switch (pnum)
        case 'p5696';
        vcnum = 'vc1535'
        case 'p5702'; % missing ho1
        vcnum = 'vc1563'
        case 'p5723';
        vcnum = 'vc1645'
        case 'p5740';
        vcnum = 'vc4103'
        case 'p5743'; 
        vcnum = 'vc4153'
        case 'p5760';
        vcnum = 'vc4336'
        case 'p5761';
        vcnum = 'vc4354'
        case 'p5771';
        vcnum = 'vc4405'
        case 'p5772';
        vcnum = 'vc4420'
        case 'p5774';
        vcnum = 'vc4426'
        case 'p5777';
        vcnum = 'vc4437'
        case 'p5780';
        vcnum = 'vc4497'
        case 'p5781';
        vcnum = 'vc4500'
        case 'p5784';
        vcnum = 'vc4520'
        case 'p5792';
        vcnum = 'vc4634'
        case 'p5807';
        vcnum = 'vc4903'
        case 'p5842';
        vcnum = 'vc5591'
        case 'p5846';
        vcnum = 'vc5625'
        case 'p5850';
        vcnum = 'vc5647'
        case 'p5856';
        vcnum = 'vc5821'
        otherwise
        	warning(['pnum_to_vcnum could not recognize ' pnum]);
        	vcnum = pnum;
    end
