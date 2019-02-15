
import mlfourdfp.*;
cd(fullfile(getenv('PPG'), 'jjlee', 'HYGLY08', 'V1', 'HO1_V1-Converted-Abs', 'HO1_V1-LM-00', ''));

return
error('emergency stop');

mlbash('sif_4dfp1 HO1_V1-LM-00-OP.mhdr HO1_V1-LM-00-OP');
mkdir('../../HO1_V1-AC-Abs');
fv = mlfourdfp.FourdfpVisitor;
fv.move_4dfp('HO1_V1-LM-00-OP', '../../HO1_V1-AC-Abs/ho1v1r1');
cd('../../HO1_V1-AC-Abs');
ho1 = mlfourd.ImagingContext('ho1v1r1.4dfp.ifh');



brainmask = mlfourd.ImagingContext('brainmaskr2_op_ho1_b15.4dfp.ifh');
brainmask.numericalNiftid
ho1.numericalNiftid
brainmask.view('ho1v2r1_sumt.4dfp.img')
brainmask = brainmask.binarized
brainmask.filesuffix = '.4dfp.ifh'
brainmask.save
brainmask = brainmask.binarized; brainmask.filesuffix = '.4dfp.ifh';
brainmask.save
ho1v2r1_mskt = ho1.masked(brainmask)
brainmask.size
ho1v2r1_mskt = ho1.masked(brainmask.numericalNiftid)
ho1v2r1_mskt.fileprefix = 'ho1v2r1_b43_mskt'; ho1v2r1_mskt.filesuffix = '.4dfp.ifh'
ho1v2r1_mskt.freeivew
ho1v2r1_mskt.freeview
ho1v2r1_mskt.view
ho1v2r1_mskt.save
ho1v2r1_sumv = ho1v2r1_mskt.volumeSummed
ho1v2r1_sumv.save
ho1v2r1_sumv
bmmr = mlsiemens.BiographMMR0.load('ho1v2r1_b43_mskt.4dfp.ifh')
sessd = mlraichle.SessionData('studyData', mlraichle.StudyData, 'sessionPath', pwd, 'vnumber', 2, 'ac', true)
bmmr = mlsiemens.BiographMMR0.loadSession(sessd, 'ho1v2r1_b43_mskt.4dfp.ifh')
this.sessionData
bmmr = mlsiemens.BiographMMR0.loadSession(sessd, 'ho1v2r1_b43_mskt.4dfp.ifh')
bmmr.times
plot(bmmr.times, ho1v2r1_sumv.img)
plot(bmmr.times, ho1v2r1_sumv.niftid.img)
brainmask
brainmask.numericalNiftid.dipsum
brainmask.numericalNiftid.dipsum*prod([2.09 2.09 2.03]/1000)
brainmask.numericalNiftid.dipsum*prod([2.09 2.09 2.03]/10)
brainmask.view
brainmask.numericalNiftid.mmppix
tmp = brainmask.numericalNiftid.img;
max(max(max(tmp)))
min(min(min(tmp)))
sum(sum(sum(tmp)))
.2*.2*.2
222885*.008
bmmr.times
bmmr.sessionData.timingData
sessd
sessd.tracer = 'HO'
bmmr = mlsiemens.BiographMMR0.loadSession(sessd, 'ho1v2r1_b43_mskt.4dfp.ifh')
ho1v2r1_sumv.img'
ho1v2r1_sumv.niftid.img'
bmmr.times'
plot(bmmr.times, ho1v2r1_sumv.niftid.img)