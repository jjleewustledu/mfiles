%  USAGE:  dipimg = read4d_cbf_datetime(idx)
%
%          idx is an integer index
%
%  $Id$
%________________________________________________________________________

function dipimg = read4d_cbf_datetime(idx) ...

apath = ['/mnt/hgfs/perfusion/vc/' pidList(idx) '/Data/cbf_MLEM_'];
dipimg = read4d([apath mlemDateTime(idx, 'cbf') '.4dfp.img'], 'ieee-be', 'single', 256,256, 8, 1, 0, 0, 0);
