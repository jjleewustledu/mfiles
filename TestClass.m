classdef TestClass

    properties
        p = 0
    end
    methods
        function g = get.p(this)
            g = p;
        end
        function this = set.p(this, s)
            this.p = s;
        end
    end    
end