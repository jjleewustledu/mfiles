% fid = fopen('E:\MOCO_SynchingPhantom_May4\Development_CihatEldeniz\009Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017042814001792100000040.bf');
% fid = fopen('E:\MOCO_SynchingPhantom_May4\Development_CihatEldeniz\029Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017042814001792100000046.bf');
% fid = fopen('E:\MOCO_SynchingPhantom_May4\Development_CihatEldeniz\040Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017042814001792100000049.bf');
% fid = fopen('E:\Y90\Y90_PMR44\CARUTHERS_MANDY_N_12257094\PetRaw\CCIR-00500_CCIR-00581_Parikh\039Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017030114220287500000020.bf');
% fid = fopen('E:\Pancreas\2004_BLJ_029_2004_BLJ_029_V5\2004_BLJ_029\CCIR-00600_CCIR-00633_Fields\015Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017040514093496800000049.bf');
fid = fopen('/Users/jjlee/Tmp/SynchingExperimentWithoutActivity/029Abd_MRAC_PET_Raw_Data/1.3.12.2.1107.5.2.38.51010.30000017042814001792100000046.bf');

words = ['GATE ON ';'GATE OFF'];

amountRead = 0;

timeStampIndices = 0;

while ~feof(fid)
    
    listModeData = fread(fid,1000000,'uint32',0,'l');
    amountRead = amountRead+100000;
    if mod(amountRead,90e6)==0
        disp(['Amount read = ' num2str(amountRead) ', Last time = ' num2str(bin2dec(listModeDataDecoded(timeStampIndices(end),2:end)))])
    end
    
    listModeDataDecoded = dec2bin(listModeData,32);
    
    timeStampIndices = find(strncmp(cellstr(listModeDataDecoded),'1000',4));
    gateONIndices =  find(strcmp(cellstr(listModeDataDecoded),'11100001000000000001000000000000'));
    gateOFFIndices = find(strcmp(cellstr(listModeDataDecoded),'11100001000000000001000000000001'));
    
    allGates = sort([gateONIndices;gateOFFIndices]);
    
    timeStampsPrecedingGates = zeros(length(allGates),1);
    decodedGates = [];
    for k = 1:length(allGates)
        ind = find(timeStampIndices<allGates(k),1,'last');
        timeStampsPrecedingGates(k) = bin2dec(listModeDataDecoded(timeStampIndices(ind),2:end));
        if any(gateONIndices==allGates(k))
            disp(['Time = ' num2str(timeStampsPrecedingGates(k)) ' ms --> ' words(1,:)])      
        else
            disp(['Time = ' num2str(timeStampsPrecedingGates(k)) ' ms --> ' words(2,:)])
        end                
    end    
end
fclose(fid);


