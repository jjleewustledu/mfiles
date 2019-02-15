%ROIIPSILESION

function roi = roiIpsiLesion(p)

[pid, p] = ensurePid(p);

ipsiLesion = { 	'L', 'L', 'L', 'R', 'L', 'R', 'L', 'L', 'R', 'L', ...
				'R', 'L', 'R', 'L', 'L', 'R', 'L', 'R', 'R'  };

PATH = [peekDrive '/perfusion/vc/' pid '/'];
left = read4d([PATH 'ROIs/left_xr3d.4dfp.img'], ...
              'ieee-be','single',256,256,8,1,0,0,0);

if (strcmp('L', ipsiLesion(p)))
    roi = squeeze(left);
else
    roi = ~squeeze(left);
end
