% fid = fopen('E:\MOCO_RADIOACTIVEPHANTOM_JAN24_RADIOACTIVEPHANTOM_JAN24\TestE7Tools_May3_2017\PatientX-Converted\PatientX-LM-00\PatientX-LM-00.l');

% fread(fid,2700*10000,'uint32',0,'l');

% for k = 1:1000
%     listModeData = fread(fid,10000,'uint32',0,'l');
% 
%     listModeDataDecoded = dec2bin(listModeData);
%     % TF = strncmp(cellstr(listModeDataDecoded),'11100001',8);
%     % listModeDataDecoded(TF,:)
% 
%     % 0001000000000000 --> Gate On
%     % 0001000000000000 --> Gate On
%     % 0010000000000001 --> Secondary R wave
%     % 0001000000000000 --> Gate On
%     % 0010000000000001 --> Secondary R wave
%     % 0001000000000001 --> Gate Off
%     % 0010000000000001 --> Secondary R wave
%     % 0001000000000001 --> Gate Off
%     % 0010000000000001 --> Secondary R wave
%     % 0001000000000000 --> Gate On
%     % 0001000000000001 --> Gate Off
%     % 0001000000000000 --> Gate On
%     % 0001000000000001 --> Gate Off
%     % 0001000000000001 --> Gate Off
% 
% %     gateONIndices =  find(strcmp(cellstr(listModeDataDecoded),'11100001000000000001000000000000'));
% %     gateOFFIndices = find(strcmp(cellstr(listModeDataDecoded),'11100001000000000001000000000001'));
%     
% %     if ~isempty(gateONIndices)
% %         keyboard;
% %     else
% %         disp(['k = ' num2str(k)])
% %     end    
% 
%     timeStampIndices = find(strncmp(cellstr(listModeDataDecoded),'1000',4));
%     
%     if ~isempty(timeStampIndices)
%         keyboard;
%     else
%         disp(['k = ' num2str(k)])
%     end 
% end

% fclose(fid);

clear
% fid = fopen('E:\MOCO_SynchingPhantom_May4\Development_CihatEldeniz\009Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017042814001792100000040.bf');
% fid = fopen('E:\MOCO_SynchingPhantom_May4\Development_CihatEldeniz\029Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017042814001792100000046.bf');
fid = fopen('/Users/jjlee/Tmp/SynchingExperimentWithoutActivity/029Abd_MRAC_PET_Raw_Data/1.3.12.2.1107.5.2.38.51010.30000017042814001792100000046.bf');
% fid = fopen('E:\MOCO_SynchingPhantom_May4\Development_CihatEldeniz\040Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017042814001792100000049.bf');
% fid = fopen('E:\Y90\Y90_PMR44\CARUTHERS_MANDY_N_12257094\PetRaw\CCIR-00500_CCIR-00581_Parikh\039Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017030114220287500000020.bf');
% fid = fopen('E:\Pancreas\2004_BLJ_029_2004_BLJ_029_V5\2004_BLJ_029\CCIR-00600_CCIR-00633_Fields\015Abd_MRAC_PET_Raw_Data\1.3.12.2.1107.5.2.38.51010.30000017040514093496800000049.bf');
listModeData = fread(fid,Inf,'uint32',0,'l');
% listModeData = fread(fid,5e7,'uint32',0,'l');
fclose(fid);
listModeDataDecoded = dec2bin(listModeData);
timeStampIndices = find(strncmp(cellstr(listModeDataDecoded),'1000',4));
gateONIndices =  find(strcmp(cellstr(listModeDataDecoded),'11100001000000000001000000000000'));
gateOFFIndices = find(strcmp(cellstr(listModeDataDecoded),'11100001000000000001000000000001'));
% Exclude very first Gate ON and very last GateOFF as they do not seem
% GIM-related.
allGates = sort([gateONIndices(2:end);gateOFFIndices(1:end-1)]);
words = ['GATE ON ';'GATE OFF'];

timeStampsPrecedingGates = zeros(length(allGates),1);
decodedGates = [];
for k = 1:length(allGates)
    ind = find(timeStampIndices<allGates(k),1,'last');
    timeStampsPrecedingGates(k) = bin2dec(listModeDataDecoded(timeStampIndices(ind),2:end));
    if any(gateONIndices==allGates(k))
        decodedGates(k,:) = words(1,:);        
    else
        decodedGates(k,:) = words(2,:);
    end        
end

for k = 1:length(allGates)
    disp(['Time = ' num2str(timeStampsPrecedingGates(k)) ' ms --> ' decodedGates(k,:)])
end

nPar = 38;
% nPar = 48;
% TR = 6.85;
TR = 3.54; % Experiments 2 and 3
% timeOfLastPartitionForLine1 = timeStampsPrecedingGates(4+(nPar-1)*4+1);
% timeOfLastPartitionForLine1801 = timeStampsPrecedingGates(end-7);
% unitTimeMR = nPar*TR+19
% unitTimePET = (timeOfLastPartitionForLine1801-timeOfLastPartitionForLine1)/1800
% (unitTimePET-unitTimeMR)/unitTimeMR*100

