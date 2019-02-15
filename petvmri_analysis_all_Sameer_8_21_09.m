function [p] = petvmri_analysis_all_Sameer(boxes)
%function petvmri_analysis_all_Sameer
   % boxes = 9;
RescaleOption = 'N'%input('Do you want to compare rescaled images? (Y or N)');
BlurredMROption = 'Y'%input('Do you want to blur the MR images using a 10mm FWHM Gaussian filter? (Y or N)');
ButanolPETOption = 'N'%input('Would you like the butanol correction applied to the PET images? (Y or N)');
threshold = 1000%input('What would you like the threshold to be to eliminate vessel artifact?'); 1000 effectivly ignore this
threshold_low = 1

%% Load masks and intitialize loop

% Set directory with desired masks
% cd('C:\Documents and Settings\Vishal\My Documents\Projects\PETMRI_Final\Masks_all_2009_08_13_no_outliers');
cd('C:\Documents and Settings\Vishal\My Documents\Projects\PETMRI_Final\Masks_retest');
% cd('C:\Documents and Settings\Vishal\My Documents\Projects\PETMRI_Final\Masks_2009_06_04');
files = dir('*.mat');
files = struct('name',(['7248','_Mask.mat']));
%intialize variables for gridding
% boxes = 6;%number of boxes in x and y
bbb = floor(128/boxes);%box width
mean_qCBF = zeros(length(files),boxes*boxes*13);
mean_petCBF = zeros(length(files),boxes*boxes*13);
min_vox = 10;
% min_vox = 10+.2*bbb*bbb;

Results_table = zeros(length(files),9);
key = 'patient, slope, intercept, R, P, mean GM mri, mean GM pet, mean WM mri, mean WM pet'

for k = 1:length(files)
load(files(k).name);
fprintf(files(k).name);
% filename = [patient_number,'_Mask'];
% load(filename);
% qCBF = qCBF2;%use AIF correct
%% Rescales rCBF using a conversion factor with 22 mL/100g/min for WM Flow
if strfind(RescaleOption,'Y')
[avg_WM sigma_WM] = fast_roi(mask_nWM, rCBF);
rescale = 22/avg_WM;
qCBF = rCBF*rescale;
end

% %% Define Grid Sizes
% a = 8;
% b = 128/a;
% c = b-1;
%% Define
if strfind(ButanolPETOption, 'Y')
    petCBF = petCBF;
else
    petCBF = petCBF2;
end
%% Blur the MR qCBF image
if strfind(BlurredMROption, 'Y')
sigma = 4.67/(sqrt(8*log(2)));
h = fspecial('gaussian',128,sigma);
qCBF=imfilter(qCBF,h); %filter MR
%%%%%%%
% petCBF=imfilter(petCBF,h);
%%%%%%
%petCBF=imfilter(petCBF,h);
end

%% qCBF: Layer mask on image, determine if unit necessary, calculate average WM

for ii = 1:13%slices
        Nx_count = 1;%count row
        image = qCBF(:,:,ii);
        image2 = petCBF(:,:,ii);

       
        for jj = 1:bbb:(128-bbb)%step boxes x direction
        Ny_count = 1;%count column

        for j = 1:bbb:(128-bbb)%step boxes y direction
            temp = image(j:j+bbb,jj:jj+bbb);%select box
            temp = temp.*(temp<threshold);%threshold removal for vessel artifact
            temp = temp.*(temp>threshold_low);%threshold removal for lower values
            temp2 = image2(j:j+bbb,jj:jj+bbb);%select box
            temp2 = temp2.*(temp2>threshold_low);%remove negative values and low values
            if(sum(sum(temp>threshold_low))>min_vox && sum(sum(temp2>threshold_low))>min_vox)%Check if there are at least min_vox voxels in the box
                
                mean_qCBF(k,(ii-1)*boxes*boxes+(Nx_count-1)*boxes+Ny_count) = sum(sum(temp))/sum(sum(temp>threshold_low));%store mean value of the box
                mean_petCBF(k,(ii-1)*boxes*boxes+(Nx_count-1)*boxes+Ny_count) = sum(sum(temp2))/sum(sum(temp2>threshold_low));
           end
            Ny_count = Ny_count+1;
        end
            Nx_count = Nx_count+1;

    end
end
end

%% Individual Plots for each patient
avg_petCBF = [];%mean_petCBF(1,:);
avg_qCBF = [];%mean_qCBF(1,:);
mqCBF_final = [];
spetCBF_final = [];
for k = 1:length(files)
    figure;
    temp = mean_petCBF(k,:);
    temp2 = mean_qCBF(k,:);

    plot(temp(temp~=0.00000), temp2(temp2~=0.00000),'.')
    name = files(k).name;
    
    fprintf(files(k).name);
    [fit] = polyfit(temp(temp~=0.00000), temp2(temp2~=0.00000),1)  
    [R,p] = corrcoef(temp(temp~=0.00000)', temp2(temp2~=0.00000)','rows','complete')
    size(R)
    titlestr = ['subject ', name(1:4), ' R = ', num2str(R(1,2)), ' p = ',num2str(p(1,2))];
    title(titlestr);
    
    Results_table(k,1) = str2double(name(1:4));
    Results_table(k,2) = fit(1);
    Results_table(k,3) = fit(2);
    Results_table(k,4) = R(1,2);
    Results_table(k,5) = p(1,2);
    
    [spetCBF index] = sort(temp(temp~=0.000));
    temp2 = temp2(temp2~=0.00000);
    mqCBF = temp2(index);
    
    avg_petCBF = [avg_petCBF mean_petCBF(k,:)];
    avg_qCBF = [avg_qCBF mean_qCBF(k,:)];
    xlim([0 120]); ylim([0 120]);
    xlabel('PET CBF ( ml/100g-min)'); ylabel('MRI CBF (ml/100g-min)');
    x = xlim;
    line([x(1) x(2)], [0 120] ,'LineStyle','--','Color','k');    
end
avg_petCBF = avg_petCBF(avg_petCBF~=0.00000);
avg_qCBF = avg_qCBF(avg_qCBF~=0.00000);

    figure;
    plot(avg_petCBF, avg_qCBF,'.')
    title(['Complete Correlation of MRI and PET CBF of Patient 1 to ' num2str(length(files))]); 
%     xlim([0 80]); ylim([0 80]);
    xlabel('PET CBF ( ml/100g-min)'); ylabel('MRI CBF (ml/100g-min)');
    polyfit(avg_petCBF, avg_qCBF,1)  

%% Combine all patient data
    xlim([0 120]); ylim([0 120]);
    xlabel('PET CBF ( ml/100g-min)'); ylabel('MRI CBF (ml/100g-min)');
    x = xlim;
    line([x(1) x(2)], [0 120] ,'LineStyle','--','Color','k');

%% Correlation Analysis for all patients
fprintf('Correlation for All Patients')
format long;

[R,p] = corrcoef(avg_petCBF', avg_qCBF','rows','complete')
titlestr = [ ' R = ', num2str(R(1,2)), ' p = ',num2str(p(1,2))];
 title(titlestr);

 A(:,1) = avg_petCBF';
A(:,2) = avg_qCBF';

%% Bland-Altman Plot for all patients
y = avg_petCBF - avg_qCBF;
x = (avg_qCBF + avg_petCBF)/2;
mean_diff = mean(y)
std_dev = std(y)
figure;

h = plot(x,y,'.');
xlabel('Average CBF ( ml/100g-min)'); ylabel('Difference CBF(PET CBF-MR CBF) (ml/100g-min)');
hold on;
xlim([0 120]); ylim([-60 60]);
x = xlim;
line([x(1) x(2)], [0 0] ,'LineStyle','--','Color','k'); 
line([x(1) x(2)], [mean_diff mean_diff],'LineStyle','--','Color','r');

hold off;
% Results_table
% close all;
% save results.mat Results_table key
cd('C:\Documents and Settings\Vishal\My Documents\Projects\PETMRI_Final\Codes');

end