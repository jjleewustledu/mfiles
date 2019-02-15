function flag = counterexists(name)
% COUNTEREXISTS - Test for existence of counter
%  
%   FLAG = COUNTEREXISTS(NAME) returns true if the counter exists. If the
%   optional parameter NAME is omitted, the default 'gccounter' is used.
%
%   The counter state is stored in the matlab preference
%   'counter_utility_data'.
%
%   Example:
%       if counterexists('MyCounter')
%           counterdelete('MyCounter')
%       end
%       checs if the counter 'MyCounter' exists, and deletes it if it does.
%       
%
%   See also: COUNTERVAL, COUNTERINIT, COUNTERSET, COUNTEREXIST,
%   COUNTERLIST and COUNTERDELETE 


%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 05-Apr-2005 15:21:08 $ 
%% $Revision: 1.00 $ 
%% DEVELOPED : 7.0.1.24704 (R14) Service Pack 1 
%% FILENAME  : counterexists.m 

if nargin == 0
    name = 'gccounter';
end
flag = ispref('counter_utility_data', name);

% Created with NEWFCN.m by Jøger Hansegård  
% Contact...: jogerh@ifi.uio.no  
% $Log$ 
% ===== EOF ====== [counterexists.m] ======  
