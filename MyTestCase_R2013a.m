classdef MyTestCase_R2013a < TestCase

    methods
        function this = MyTestCase_R2013a(varargin)
            this = this@TestCase(varargin{:});
            setenv('MLUNIT_TESTING', 'true');   
            setenv('DEBUG', 'true');
        end
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/MyTestCase_R2013b.m] ======  
