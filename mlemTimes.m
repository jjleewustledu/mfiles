%MLEMTIMES
%
%  USAGE:  [aTime] = mlemTimes(idx, metric)
%
%          idx is an integer index
%          metrix is 'cbf', 'cbv' or 'mtt'
%
%  SYNOPSIS:
%
%  SEE ALSO:  'Cell Arrays of Strings' or 'strings, cells arrays of' in Matlab help.
%
%  $Id$
%________________________________________________________________________
function [aTime] = mlemTimes(idx, metric)

cbfTimes = { '633114380764218750' ...
          '633114623366093750' ...
          '633114686383437500' ...
          '633114762194531250' ...
          '633114840016718750' ...
          '633114914590625000' ...
          '633114991282656250' ...
          '633115043489218750' ...
          '633115111121875000' ...
          'vc4437' ...
          'vc4497' ...
          'vc4500' ...
          '633115172768750000' ...
          '633115243325156250' ...
          '633115310792343750' ...
          '633115386283750000' ...
          '633115464247812500' ...
          '633115521977187500' ...
          '633115589135781250' };
      
      
cbvTimes = { '633114379641093750' ...
          '633114622568750000' ...
          '633114685469843750' ...
          '633114761389843750' ...
          '633114839229375000' ...
          '633114913780625000' ...
          '633114990472343750' ...
          '633115042704062500' ...
          '633115110389531250' ...
          'vc4437' ...
          'vc4497' ...
          'vc4500' ...
          '633115171925781250' ...
          '633115242528750000' ...
          '633115309982500000' ...
          '633115385484687500' ...
          '633115463396718750' ...
          '633115521177968750' ...
          '633115588414531250' };
      
mttTimes = { '633114380205000000' ...
          '633114622970156250' ...
          '633114685930156250' ...
          '633114761788750000' ...
          '633114839621250000' ...
          '633114914185312500' ...
          '633114990877031250' ...
          '633115043090156250' ...
          '633115110760468750' ...
          'vc4437' ...
          'vc4497' ...
          'vc4500' ...
          '633115172344218750' ...
          '633115242929531250' ...
          '633115310390781250' ...
          '633115385883125000' ...
          '633115463820156250' ...
          '633115521585000000' ...
          '633115588769687500' };          
         
sizes = size(cbfTimes);
len   = sizes(2);

switch metric
    case 'cbf'
        if (idx < 1)
            aTime = cbfTimes;          
        elseif (idx > len)    
            aTime = cbfTimes(len);
            aTime = char(aTime);
        else
            aTime = cbfTimes(idx);
            aTime = char(aTime);
        end
    case 'cbv'
        if (idx < 1)
            aTime = cbvTimes;          
        elseif (idx > len)    
            aTime = cbvTimes(len);
            aTime = char(aTime);
        else
            aTime = cbvTimes(idx);
            aTime = char(aTime);
        end
    case 'mtt'
        if (idx < 1)
            aTime = mttTimes;          
        elseif (idx > len)    
            aTime = mttTimes(len);
            aTime = char(aTime);
        else
            aTime = mttTimes(idx);
            aTime = char(aTime);
        end
    otherwise
        error(['mlemTimes could not recognize ' metric]);
end
