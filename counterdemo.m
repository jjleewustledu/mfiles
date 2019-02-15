% COUNTERDEMO - Demo script for counter functionality
%  
%   COUNTERDEMO starts a demo for the counter functions

%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 20-Apr-2005 00:36:24 $ 
%% $Revision: 1.00 $ 
%% DEVELOPED : 7.0.4.365 (R14) Service Pack 2 
%% FILENAME  : counterdemo.m 
echo on
more on
%Initialize a counter 'MyCounter' and return its current value:
counterinit('MyCounter')

%Increase the counter by one
counterinc('MyCounter');

%Display the value of 'MyCounter
counterval('MyCounter')

%List the active counters
counterlist

%Evaluate if the counter 'MyCounter2' exists
counterexists('MyCounter2')

%Create a counter 'MyCounter2'
counterinit('MyCounter2');

%Set the counter to the value 4
counterset('MyCounter2', 4);

%Increase the counter in a loop
for i = 1:5
    counterinc('MyCounter');
    disp(counterval('MyCounter'))
end

%List the current counters:
counterlist

%Get the value of 'MyCounter2'
counterval('MyCounter2')

%Clean up
counterdelete('MyCounter')
counterdelete('MyCounter2');

%Verify that the counters does not exist
counterexists ('MyCounter')

counterexists('MyCounter2')

more off
echo off






% Created with NEWFCN.m by Jøger Hansegård  
% Contact...: jogerh@ifi.uio.no  
% $Log$ 
% ===== EOF ====== [counterdemo.m] ======  
