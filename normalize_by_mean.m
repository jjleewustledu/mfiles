function [mpetvecs, mmlemvecs, mlaifvecs] = normalize_by_mean(petvecs, mlemvecs, laifvecs)

mpetvecs = cell(size(petvecs));
for i = 1:16
    meanpet     = mean(petvecs{i})
    onesvecs    = ones(size(petvecs{i}, 1), 1);
    mpetvecs{i} = 100*(petvecs{i} - onesvecs*meanpet)/meanpet;
end

mmlemvecs = cell(size(mlemvecs));
for i = 1:16
    meanmlem     = mean(mlemvecs{i})
    onesvecs     = ones(size(mlemvecs{i}, 1), 1);
    mmlemvecs{i} = 100*(mlemvecs{i} - onesvecs*meanmlem)/meanmlem;
end

mlaifvecs = cell(size(laifvecs));
for i = 1:16
    meanlaif     = mean(laifvecs{i})
    onesvecs     = ones(size(laifvecs{i}, 1), 1);
    mlaifvecs{i} = 100*(laifvecs{i} - onesvecs*meanlaif)/meanlaif;
end
