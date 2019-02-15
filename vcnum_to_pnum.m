
function pnum = vcnum_to_pnum(vcnum)

    switch (vcnum)
        case 'vc1535'
        pnum = 'p5696';
        case 'vc1563'
        pnum = 'p5702'; % missing ho1
        case 'vc1645'
        pnum = 'p5723';
        case 'vc4103'
        pnum = 'p5740';
        case 'vc4153'
        pnum = 'p5743'; 
        case 'vc4336'
        pnum = 'p5760';
        case 'vc4354'
        pnum = 'p5761';
        case 'vc4405'
        pnum = 'p5771';
        case 'vc4420'
        pnum = 'p5772';
        case 'vc4426'
        pnum = 'p5774';
        case 'vc4437'
        pnum = 'p5777';
        case 'vc4497'
        pnum = 'p5780';
        case 'vc4500'
        pnum = 'p5781';
        case 'vc4520'
        pnum = 'p5784';
        case 'vc4634'
        pnum = 'p5792';
        case 'vc4903'
        pnum = 'p5807';
        case 'vc5591'
        pnum = 'p5842';
        case 'vc5625'
        pnum = 'p5846';
        case 'vc5647'
        pnum = 'p5850';
        case 'vc5821'
        pnum = 'p5856';
        otherwise
        	warning(['vcnum_to_pnum could not recognize ' vcnum]);
        	pnum = vcnum;
    end


