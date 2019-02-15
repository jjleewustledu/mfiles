function counterset(varargin)
% COUNTERSET - Set counter to specific value
%  
%   COUNTERSET(VAL) sets the default counter 'gccounter' to the specified
%   value VAL.
%
%   COUNTERSET(NAME, VAL) sets the counter specified by the NAME to the
%   specified value VAL.
%   
%   If the counter does not exist, it is created and set to the specified
%   value.
%
%   The counter state is stored in the matlab preference
%   'counter_utility_data'.
%
%    Example: 
%       counterinit('MyCounter');
%       counterset('MyCounter', 10);
%       CurrentValue = counterval('MyCounter') 
%    initializes the counter 'MyCounter', sets it to the value 10, 
%    and reads the value of the counter 'MyCounter');
%
%   See also: COUNTERVAL, COUNTERINIT, COUNTERSET, COUNTEREXIST,
%   COUNTERLIST and COUNTERDELETE 



%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 19-Apr-2005 23:51:01 $ 
%% $Revision: 1.00 $ 
%% DEVELOPED : 7.0.4.365 (R14) Service Pack 2 
%% FILENAME  : counterset.m 
switch nargin 
    case 1
        name = 'gccounter';
        value = varargin{1};
    case 2
        name = varargin{1};
        value = varargin{2};
    otherwise
        error('Invalid number of input arguments');
end
counter.val = value;
counter.updated = now;

if counterexists(name)
    setpref('counter_utility_data', name, counter);
else
    addpref('counter_utility_data', name, counter);
end






% Created with NEWFCN.m by Jøger Hansegård  
% Contact...: jogerh@ifi.uio.no  
% $Log$ 
% ===== EOF ====== [counterset.m] ======  
