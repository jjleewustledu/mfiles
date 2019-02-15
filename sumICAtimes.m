function synth = sumICAtimes(times)

timesSizes = size(times);
synth = newim(timesSizes(2));
Ncomps = timesSizes(1);

%%%switches = [ 1 0 1 1 0 0 1 0 1 0 ];
switches = [ 1 1 1 1 1 1 1 1 1 1 ];
%%%switches = [ 1 0 0 0 0 0 0 0 0 0 ];

sums = newim(synth);
for c = 0:Ncomps-1
    if (switches(c+1)) 
        sums = sums + squeeze(times(c,:)).*squeeze(times(c,:));
    end
end
synth = sums;

