function lpdf = lognormpdf(x, mu, sigma)
%% LOGNORMPDF ... 
%   
%  Usage:  lognormpdf(x, mu, sigma) 
%          ^ log of normpdf
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.11.0.584 (R2010b) 
%% $Id$ 

lpdf = -(x-mu).^2/(2*sigma.*sigma) -log(sigma) - 0.5*log(2*pi);

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mpackages/mfiles/lognormpdf.m] ======  
