
function [idx name] = NWImagesNames(name)

%     names = { 'CBV_DSC',       'CBF_nSVD',      'CMTT_nSVD',       'TmaxMap_nSVD',      'dBATmap', 'IR_pre', ...
%               'IR_post', 'T1map_post',    'M0map_post',    'InvFmap_post',    'RESNORMmap_post', ...
%               'T1map_pre',     'M0map_pre',     'InvFmap_pre',     'RESNORMmap_pre',    'qCBF_nSVD', ...
%               'qCBV_DSC' };

    names = { 'CBV_DSC',        'CBF_nSVD',        'CMTT_nSVD',     'T1map_post',    'M0map_post', ...
              'InvFmap_post',   'RESNORMmap_post', 'T1map_pre',     'M0map_pre',     'InvFmap_pre', ...
              'RESNORMmap_pre', 'qCBF_nSVD',       'qCBV_DSC' };
          
    if (isa(name,'double'))
        idx  = name;
        name = names{idx};
    else
        idx = -1;
        for i = 1:length(names)
            if (strcmp(name,names{i}))
                idx = i;
                break;
            end
        end
    end
    
    
