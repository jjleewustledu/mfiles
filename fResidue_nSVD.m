function Residue = fResidue_nSVD(AIF,Cmt,Dt,Wij)

% Residue = fResidue_nSVD(AIF,Cmt,Dt,Wij)
%
% Singular decomposition method (SVD) using smotthing AIF
% author:   Wanyong Shin
%
% description: based on the fast water exchange assumption,  
% CBV values is generally underestimated according to dR1
% using correction factor, underestimated CBV can be calibralted  
% water exchange rate can be chosen one of 1,5,10 sec.
%
% references:  Magn Reson Med. 
%
% status:   stable

% versions
%   [04-02-02] (WYS): initial version
%   [05-08-30] (WYS): modified 


% in case that AIF is not structure
if isfield(AIF,'Ct')
    temp_AIF.Ct = AIF.Ct;
else
    temp_AIF.Ct = AIF;
end
if isfield(AIF,'BATP')
    temp_AIF.BATP = AIF.BATP;
else
    temp_AIF.BATP = 1;
end
if isfield(AIF,'RTP')
    temp_AIF.RTP = AIF.RTP;
else
    temp_AIF.RTP = length(temp_AIF.Ct);
end

% smoothing AIF 
N = length(temp_AIF.Ct);
input_AIF = [temp_AIF.Ct(1) (temp_AIF.Ct(1:N-2)+4*temp_AIF.Ct(2:N-1)+temp_AIF.Ct(3:N))/6 temp_AIF.Ct(N)];
input_AIF = input_AIF(temp_AIF.BATP:temp_AIF.RTP);
% input_AIF = temp_AIF.Ct(temp_AIF.BATP:temp_AIF.RTP);
input_Cmt = Cmt(temp_AIF.BATP:temp_AIF.RTP);
n = length(input_AIF);

% make AIF matrix
for i = 1:n
    for j=1:i
        AIF_Mat(i,j) = Dt*input_AIF(i-j+1) ;
    end
end 

% sigular value decomposition
[U,S,V] = svd(AIF_Mat);
inv_S = invert_S(S,Wij); 
invA_mat = V*inv_S*U';

% calculation Residue function
Residue = (invA_mat*input_Cmt')';

% clear variables
clear AIF Cmt Dt Wij input_AIF input_Cmt AIF_Mat U S V inv_S invA_mat 