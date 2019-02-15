%PROCESSROI
%

function checking = processRoi(path, x0, x1, y0, y1, z0, z1, t0, t1)

stemsin = { 'csf0'; 'grey0';'interior0'; 'white0' };
            
            %%% 'caudate0'; 'cerebellum0'; 'hippocampus0'; 'putamen0'; 'sinus0'; 'thalamus0' };
     %%% 
stemsin = cellstr(stemsin);
stemsout = { 'csf'; 'grey'; 'interior'; 'white' };
              
             %%% 'caudate'; 'cerebellum'; 'hippocampus';'putamen'; 'sinus'; 'thalamus' };
      %%% 
stemsout = cellstr(stemsout);
insuff = '.4dbool.img';
outsuff = '.4dfp.img';
     
for i = 1:4
    disp(['evaluating invTrimimage on ' path stemsin{i} insuff]);
    if (strcmp('interior', stemsin{i}))
        checking = ...
            invTrimimage(path, [stemsin{i} insuff], [stemsout{i} outsuff], x0, x1, y0, y1, z0, z1, t0, t1);
    else
        toss = ...
            invTrimimage(path, [stemsin{i} insuff], [stemsout{i} outsuff], x0, x1, y0, y1, z0, z1, t0, t1);
    end
end

disp(['finished processing ROIs in ' path]);
