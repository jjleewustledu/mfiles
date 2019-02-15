function crc_out = crc32_adler(crc, buf)
    %% CRC32_ADLER implements "Fast CRC algorithm?" from
    %  https://stackoverflow.com/questions/27939882/fast-crc-algorithm .  The accepted answer is an algorithm 
    %  provided by Mark Adler.
    %
    %  Here is a short CRC32 using either the Castagnoli polynomial (same one as used by the Intel crc32 instruction), 
    %  or the Ethernet polynomial (same one as used in zip, gzip, etc.).  The initial crc value should be zero. 
    %  The routine can be called successively with chunks of the data to update the CRC.  You can unroll the inner loop 
    %  for speed, though your compiler might do that for you anyway.
    % 
    %  @param cin is initial CRC32 checksum.
    %  @param buf is unsigned char.
    %  @return CRC32 checksum.
    %
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

    %% CRC-32C (iSCSI) polynomial in reversed bit order.
    %  POLY = uint32(hex2dec('82f63b78'));

    %% CRC-32 (Ethernet, ZIP, etc.) polynomial in reversed bit order.
    POLY = uint32(hex2dec('edb88320'));
    
    crc = bitcmp(uint32(crc));
    buf = uint8(buf);
    len = length(buf);
    len0 = len;
    while (len)
        len = len-1;
        crc = bitxor(crc, uint32(buf(len0-len)));
        for k = 0:7
            if (bitand(crc, 1))
                crc = bitxor(bitshift(crc, -1), POLY);
            else
                crc = bitshift(crc, -1);
            end
        end
    end
    crc_out = bitcmp(crc);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/crc32_adler.m] ======  
