function array_for_c(a)
%% ARRAY_FOR_C ... 
%   
%  Usage:  array_for_c(a) 
%                      ^ numerical row-vector 
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

tens = length(a)/10;

for lin = 1:floor(tens)
    aa = a(10*lin-9:10*lin);
    fprintf(...
        '%g, %g, %g, %g, %g, %g, %g, %g, %g, %g,\n',...
        aa(1), aa(2), aa(3), aa(4), aa(5), aa(6), aa(7), aa(8), aa(9), aa(10));
end

if (mod(length(a),10) > 0)
    af = a(floor(tens)+1:length(tens));
    for itm = 1:length(af)-1
        fprintf('%g, ', af(itm));
    end
        fprintf('%g\n', af(length(af)));
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/array_for_c.m] ======  
