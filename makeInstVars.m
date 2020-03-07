function makeInstVars(varargin)
    %% MAKEINSTVARS ... 
    %  Usage:  makeInstVars() 
    %          ^ 
    %% Version $Revision$ was created $Date$ by $Author$,  
    %% last modified $LastChangedDate$ and checked into repository $URL$,  
    %% developed on Matlab 9.4.0.813654 (R2018a).  Copyright 2018 John Joowon Lee. 

    fprintDepProp(varargin{:});
    fprintf('\n');
    fprintGetters(varargin{:});
    fprintf('\n');
    fprintCtor(varargin{:});
    fprintf('\n');
    fprintPrivProp(varargin{:});
    
    function fprintDepProp(v)
        fprintf('properties (Dependent)\n');
        for iv = 1:length(v)
            fprintf('\t\t%s\n', v{iv});
        end
        fprintf('\tend\n');
    end
    
    function fprintGetters(v)
        fprintf('\t\t%%%% GET\n\n');        
        for iv = 1:length(v)
            fprintf('\t\tfunction g = get.%s(this)\n', v{iv});
            fprintf('\t\t\tg = this.%s_;\n', v{iv});
            fprintf('\t\tend\n\n');
        end
        fprintf('\t\t%%%%\n');
    end

    function fprintCtor(v)
        fprintf('\t\tfunction this = (varargin)\n');
        fprintf('\n');
        fprintf('\t\t\tip = inputParser;\n');
        for iv = 1:length(v)
            fprintf('\t\t\taddParameter(ip, ''%s'', , @);\n', v{iv});
        end
        fprintf('\t\t\tparse(ip, varargin{:})\n');
        for iv = 1:length(v)
            fprintf('\t\t\tthis.%s_ = ip.Results.%s;\n', v{iv}, v{iv});
        end
        fprintf('\t\tend\n');
    end

    function fprintPrivProp(v)
        fprintf('\t%%%% PRIVATE\n\n'); 
        fprintf('\tproperties (Access = private)\n');
        for iv = 1:length(v)
            fprintf('\t\t%s_\n', v{iv});
        end
        fprintf('\tend\n');
    end





end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/makeInstVars.m] ======  
