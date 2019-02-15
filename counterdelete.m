function counterdelete(name)
% COUNTERDELETE - Permanently remove counter
%  
%   COUNTERDELETE(NAME) removes the counter specified by name permanently.
%   If no name is specified, the default counter 'gccounter' is deleted.
%
%   The counters are read from the matlab preference
%   'counter_utility_data'.
%
%   Example:
%       counterinit('MyCounter')
%       counterdelete('MyCounter');
%       counterlist
%   Creates a counter 'MyCounter', deletes it and displays a list of active
%   counters.

%   See also: COUNTERVAL, COUNTERINIT, COUNTERSET, COUNTEREXIST,
%   COUNTERLIST and COUNTERDELETE 


%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 05-Apr-2005 15:20:15 $ 
%% $Revision: 1.00 $ 
%% DEVELOPED : 7.0.1.24704 (R14) Service Pack 1 
%% FILENAME  : counterdelete.m 

if nargin == 0
    name = 'gccounter';
end
if counterexists(name)
    rmpref('counter_utility_data', name);
else
    error('Could not delete non existing counter: %s', name);
end


% Created with NEWFCN.m by Jøger Hansegård  
% Contact...: jogerh@ifi.uio.no  
% $Log$ 
% ===== EOF ====== [counterdelete.m] ======  
