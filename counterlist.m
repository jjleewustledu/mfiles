function counterlist()
% COUNTERLIST - Lists the initialized counters
%  
%   COUNTERLIST displays a list of initialized counters and their values.
%
%   The counters are read from the matlab preference
%   'counter_utility_data'.
%
%   Example:
%       counterinit('MyCounter')
%       counterinc('MyCounter')
%       counterlist
%    initializes the counter 'MyCounter', increases it by one, and
%    displays the list of current counters.
%
%   See also: COUNTERVAL, COUNTERINIT, COUNTERSET, COUNTEREXIST,
%   COUNTERLIST and COUNTERDELETE 


%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 19-Apr-2005 23:57:56 $ 
%% $Revision: 1.00 $ 
%% DEVELOPED : 7.0.4.365 (R14) Service Pack 2 
%% FILENAME  : counterlist.m 

counters = getpref('counter_utility_data');
if isempty(counters)
    disp('No counters are initialized');
else
    names = fieldnames(counters);
    disp(sprintf('Found %i counters:', numel(names)));
    for i = 1:numel(names)
        disp(sprintf('%s: %s', names{i}, mat2str(counters.(names{i}).val)));
    end
end
        
        








% Created with NEWFCN.m by Jøger Hansegård  
% Contact...: jogerh@ifi.uio.no  
% $Log$ 
% ===== EOF ====== [counterlist.m] ======  
