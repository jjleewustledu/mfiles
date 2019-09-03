function make_avgt(varargin)

ip = inputParser;
addOptional(ip, 'project', 'CCIR_00993', @ischar)
addParameter(ip, 'home', '/data/nil-bluearc/shimony/jjlee', @isdir)
parse(ip, varargin{:});

import mlsystem.DirTool2;
pwd0 = pushd(fullfile(ip.Results.home, ip.Results.project, ''));
dtses = DirTool2('ses-E*');
for ses = dtses.dns
   pwd1 = pushd(ses{1});
   dttra = DirTool2('*_DT*');
   for tra = dttra.dns
       pwd2 = pushd(tra{1});
       dt4dfp = DirTool2('*r1.4dfp.hdr');
       for fdfp = dt4dfp.fns
           
           ic2 = mlfourd.ImagingContext2(fdfp{1});
           ic2 = ic2.timeAveraged;
           ic2.fsleyes;
           ic2.save
       
       end
       popd(pwd2)
   end
   popd(pwd1)
end

popd(pwd0)