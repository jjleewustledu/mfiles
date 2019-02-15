function cbf = linkMexFlowButanol(cbf)
%% LINKMEXFLOWBUTANOL ... 
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

MIN = 1; MAX = 159; MODEL = 'j'; % Joanne Markham's interpretation of Herscovich's model

cbf   = squeeze(cbf .* (cbf < MAX) .* (cbf > MIN)) + sqrt(eps);
cbfsz = size(cbf);
rank  = length(size(cbf));
switch (rank)
    case 2
        for y = 1:cbfsz(2)
            for x = 1:cbfsz(1)
                cbf(x,y) = mexFlowButanol(cbf(x,y), MODEL);
            end
        end
    case 3
        for z = 1:cbfsz(3) %#ok<*FORFLG>
            for y = 1:cbfsz(2)
                for x = 1:cbfsz(1)
                    cbf(x,y,z) = mexFlowButanol(cbf(x,y,z), MODEL);
                end
            end
        end
    case 4
        for t = 1:cbfsz(4)
            for z = 1:cbfsz(3) %#ok<*FORFLG>
                for y = 1:cbfsz(2)
                    for x = 1:cbfsz(1)
                        cbf(x,y,z,t) = mexFlowButanol(cbf(x,y,z,t), MODEL);
                    end
                end
            end
        end
    otherwise
        error('mfile:UnsupportedArraySize', 'linkMexFlowButanol.size->%s', num2str(size(cbf)));
end
% toc -> 5.402872 s for random('Normal', 50, 15, [100 100 50])

% cbf = arrayfun(@(x) mexFlowButanol(x, MODEL), cbf);
% toc -> 14.631916 s for same






% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/linkMexFlowButanol.m] ======  
