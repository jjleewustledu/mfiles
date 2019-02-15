function N = counterinc(name)
% COUNTERINC - Increase counter and return new value
%  
%   N = COUNTERINC(NAME) Increases the counter specified by NAME, and
%   return its new value. If NAME is omitted, the default 'gccounter' is
%   used.
%
%   The counters are read from the matlab preference
%   'counter_utility_data'.
%
%   Example: 
%       counterinit('MyCounter');
%       counterset('MyCounter', 4);
%       counterinc('MyCounter');
%       disp(counterval('MyCounter'));
%   Initializes a counter and sets the value to 4. The counter is then
%   increased by one, and the counter value is displayed.
%
%   See also: COUNTERVAL, COUNTERINIT, COUNTERSET, COUNTEREXIST,
%   COUNTERLIST and COUNTERDELETE 

%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 05-Apr-2005 15:09:44 $ 
%% $Revision: 1.00 $ 
%% DEVELOPED : 7.0.1.24704 (R14) Service Pack 1 
%% FILENAME  : counterinc.m 

if nargin == 0
    name = 'gccounter';
end

if ~counterexists(name)
    error('Failed to set value of a non-existent counter');
end

counter = getpref('counter_utility_data', name);
counter.val = counter.val+1;
counter.updated = now;
setpref('counter_utility_data', name, counter);
N = counter.val;


% Created with NEWFCN.m by Jøger Hansegård  
% Contact...: jogerh@ifi.uio.no  
% $Log$ 
% ===== EOF ====== [counterinc.m] ======  
