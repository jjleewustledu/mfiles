function paramError(obj, pname, pvalue)
%% PARAMERROR generates a message ID & error message for passed parameters, then 
%             calls error()
%   
%  Usage:  paramError(obj, pname, pvalue) 
%                     ^ matlab object throwing the error; may be empty '', or [], or {}
%                          ^ name of errant param 
%                                 ^ string or numeric value to include in error message
%
%     message ID is a string of the form
%   
%         [component:]component:mnemonic
%   
%     that enables MATLAB to identify with a specific error. The string
%     consists of one or more COMPONENT fields followed by a single
%     MNEMONIC field. All fields are separated by colons. Here is an
%     example identifier that has 2 components and 1 mnemonic.
%   
%         'myToolbox:myFunction:fileNotFound'
%   
%     The COMPONENT and MNEMONIC fields must begin with an 
%     upper or lowercase letter which is then followed by alphanumeric  
%     or underscore characters. 
%   
%     The COMPONENT field specifies a broad category under which 
%     various errors can be generated. The MNEMONIC field is a string 
%     normally used as a tag related to the particular message.
%   
%     From the command line, you can obtain the message identifier for an 
%     error that has been issued using the MException.last function. 
%
%     See also MException, MException/throw, try, catch, sprintf, dbstop,
%              errordlg, warning, disp, dbstack.
%% Version $Revision$ was created $Date$ by $Author$  
%% and checked into svn repository $URL$ 
%% Developed on Matlab 7.10.0.499 (R2010a) 
%% $Id$ 

if (~isempty(obj))
    met = metaclass(obj);
    mid = 'Matlab:';
    if (~isempty(met.ContainingPackage.Name)); strcat(mid, met.ContainingPackage.Name, ':'); end
    if (~isempty(met.Name)); strcat(mid, met.Name, ':'); end
    mid = strcat(mid, 'ParameterError');
else
    mid = 'Matlab:meta:ParameterError';
end
switch (class(pvalue))
case {'integer', 'single', 'double', 'complex', 'dip_image'}
    msg = sprintf('%s has unsupported value:  %g', pname, pvalue);
case  'char'
    msg = sprintf('%s has unsupported value:  %s', pname, pvalue);
otherwise
    msg = sprintf('%s has unsupported values', pname);
end
    
msgstruct = struct('identifier', mid, 'message', msg, 'stack', dbstack('-completenames'));
error(msgstruct);








% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mfiles/paramError.m] ======  
