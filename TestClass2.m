classdef TestClass2

    properties
        p = 0
    end
    methods
        function g = get.p(this)
            g = this.p;
        end
        function this = set.p(this, s)
            this.p = s;
        end
    end    
end