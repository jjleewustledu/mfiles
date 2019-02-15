function N = counterinit(name)
% COUNTERINIT - Initialize counter
%  
%   N = COUNTERINIT(NAME) initializes a counter of specified name to the
%   value 1 and returns the value.
%
%   COUNTERINIT(NAME) initializes a counter of specified name to the value
%   1, but does not return any value.
%
%   If no name is supplied, the default 'gccounter' is created.
%
%   The counter state is stored in the matlab preference
%   counter_utility_data.
%
%   Example: 
%       counterinit('MyCounter') 
%   initializes the counter 'MyCounter'.
%
%   See also: COUNTERVAL, COUNTERINIT, COUNTERSET, COUNTEREXIST,
%   COUNTERLIST and COUNTERDELETE 


%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 05-Apr-2005 15:01:44 $ 
%% $Revision: 1.00 $ 
%% DEVELOPED : 7.0.1.24704 (R14) Service Pack 1 
%% FILENAME  : counterinit.m 
if nargin == 0
    name = 'gccounter';
end

counter.val = 1;
counter.updated = now;
if counterexists(name)
    setpref('counter_utility_data', name, counter);
else
    addpref('counter_utility_data', name, counter);
end
N = counter.val;
% Created with NEWFCN.m by Jøger Hansegård  
% Contact...: jogerh@ifi.uio.no  
% $Log$ 
% ===== EOF ====== [counterinit.m] ======  
