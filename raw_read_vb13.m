function [y, raw] =raw_read_vb13(filename, slice_no, echo_no, acq_no, rep_no, chan_no)
 
 %
 %
fp=fopen(filename,'r');

[junk, count]=fread(fp, 1, 'uint32');
y1= sprintf('%d', junk)
[junk2, count]=fread(fp, junk -4, 'uchar');

[header, count]=fread(fp, 64, 'ushort');

DMALength = header(1) + (header(2)) * 256 * 256;
SamplesInScan= header(13 +2)
chan_no=header(14 +2); 
line= header(15 +2);
acq=header(16 +2);
slice= header(17 +2);
part=header(18 +2);  %% partition
echo = header(19 +2);
phase= header(20 +2);
rep= header(21 +2);  %% repitition 
KSpaceCenterColumn= header(31 +2); 
KSpaceCenterLineNo = header(37 +2);
free= header(43 +2); %% free parameters

chan_id=header(63);  %% chan id of receiver
 
[line slice part echo phase rep header(63)]

raw=zeros(chan_no, slice_no, echo_no, (SamplesInScan/2*3/4), SamplesInScan/2);

while(1>0)
    st= ftell(fp);
    [val, count]=fread(fp, 2 * SamplesInScan, 'float32'); 
    sp= ftell(fp);
    if count <2 * SamplesInScan
       message = ferror(fp) 
       size(val)
       [header, count]=fread(fp, 64, 'ushort');
       if count < 64
           count
           header
        break;
       end
        line= header(15 +2);
        acq=header(16 +2);
        slice= header(17 +2);
        part=header(18 +2);
        echo = header(19 +2);
        phase= header(20 +2);
        rep= header(21 +2);
          chan_id=header(63);
        free= header(43 +2); 
       [line slice echo]
        continue;
    else 
         slice= part;   %% 3D acquisition
         for i=1:2:SamplesInScan
            raw(chan_id+1, slice+1, echo+1, line+1, (i+1)/2)= raw(chan_id+1, slice+1, echo+1, line+1, (i+1)/2)...
               + (-1)^rep*  complex(val(2*i -1), val(2*i));
        end
  end
  
 if feof(fp)
     break;
 end

 [header, count]=fread(fp, 64, 'ushort');
 if count < 64
     break;
 end
line= header(15 +2);
acq=header(16 +2);
slice= header(17 +2);
part=header(18 +2);
echo = header(19 +2);
phase= header(20+2 );
rep= header(21+2);
KSpaceCenterColumn= header(31+2);
KSpaceCenterLineNo = header(37+2);
 chan_id=header(63);
free= header(43 +2);
 [line slice part free phase rep chan_id]
end

raw=raw(:,:,:,1:48,:);

for ch=1:chan_no
     for e=1:echo_no
         y(ch,:,e,:,:)=fftshift(ifftn(fftshift(squeeze(raw(ch,:,e,:,:))))); 
     end
end