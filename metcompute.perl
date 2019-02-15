#!/usr/local/bin/perl

print ">> launching metcompute.perl...\n";
          #########################         

$path = "/data/mozart/data2/np287/";
@folder = qw(
	     vc4103_p5740/
	     vc4153_p5743/
	     vc4336_p5760/
	     vc4354_p5761/
	     vc4405_p5771/
	     vc4420_p5772/
	     vc4426_p5774/
	     vc4437_p5777/
	     vc4497_p5780/
	     vc4500_p5781/
	     vc4520_p5784/
	     vc4634_p5792/
	     vc4903_p5807/
	     );
$len_folder = @folder;
@pnum = qw(
	     5740
	     5743
	     5760
	     5761
	     5771
	     5772
	     5774
	     5777
	     5780
	     5781
	     5784
	     5792
	     5807
	     );
$len_pnum = @pnum;

print "len folder -> $len_folder; len pnum -> $len_pnum\n";
$len_folder == $len_pnum || die "mismatch of folder and pnum lists...please debug";

for ($findx = 0; $findx <= (@folder - 1); $findx++) 
{
    $path2 = $path.$folder[$findx];
    print "   working in path $path2\n";
    print "   executing ". "cd $path2; metcompute.bin 524288 rp".$pnum[$findx]."ho1_g5.img p".$pnum[$findx]."ho1_g3.hdr rp".$pnum[$findx]."cbf_g5.img\n";
    system("cd $path2; metcompute.bin 524288 rp".$pnum[$findx]."ho1_g5.img p".$pnum[$findx]."ho1_g3.hdr rp".$pnum[$findx]."cbf_g5.img");

}

