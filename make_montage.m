function h = make_montage(metric)

load('p_complete_2009nov19.mat');
pnums =  {         'p7153'  'p7146'   'p7189'  'p7191'  'p7194'  'p7217'  'p7219'  'p7229'  'p7230'  ...
         'p7243'  'p7248'  'p7257'   'p7260'  'p7266'  'p7267'  'p7270'           'p7321'  'p7335'  ...
                  'p7338'            'p7395'};
premetrics =     {'p'      'q'};

imgs  = zeros(128,128,1,length(pnums)*length(premetrics));
imgs2 = zeros(128, 88,1,length(pnums)*length(premetrics));
for m = 1:length(premetrics)
    for k = 1:length(pnums)   
        sname           = ['slice' num2str(p.(pnums{k}).sliceidx)];
        mname           = [premetrics{m} metric];
        k1              = k + (m - 1)*length(pnums);
        imgs( :,:,:,k1) = flip4d(p.(pnums{k}).(sname).(mname), 'ty');
        imgs2(:,:,:,k1) = imgs(:,20:107,:,k1);
    end
end

h = montage(imgs2, 'DisplayRange', [0 10], 'Size', [length(premetrics) length(pnums)]);
