function N = counterval(name)
% COUNTERVAL - get current value of counter without increment
%  
%   N = COUNTERVAL(NAME) reads the current value of a counter with name
%   NAME without altering its state.
%
%   N = COUNTERVAL reads the current value of the default counter
%   'gccounter' and returns the value.
%
%   The counter state is stored in the matlab preference
%   counter_utility_data.
%
%   Example: 
%       counterinit('MyCounter');
%       CurrentValue = counterval('MyCounter') 
%   initializes and reads the value of the counter 'MyCounter');
%
%   See also: COUNTERVAL, COUNTERINIT, COUNTERSET, COUNTEREXIST,
%   COUNTERLIST and COUNTERDELETE 

%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 05-Apr-2005 15:06:43 $ 
%% $Revision: 1.00 $ 
%% DEVELOPED : 7.0.1.24704 (R14) Service Pack 1 
%% FILENAME  : counterval.m 

if nargin == 0
    name = 'gccounter';
end

if ~counterexists(name)
    error('Could not read value of a non-existent counter');
end

counter = getpref('counter_utility_data', name);
N = counter.val;






% Created with NEWFCN.m by Jøger Hansegård  
% Contact...: jogerh@ifi.uio.no  
% $Log$ 
% ===== EOF ====== [counterval.m] ======  
