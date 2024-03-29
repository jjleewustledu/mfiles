function newfcn(fcnname)
% NEWFCN create a MATLAB function with entered filename
%
%   NEWFCN creates a M-File having the entered filename and a specific
%   structure which helps for creating the main function structure. It
%   would be opened and the starting line for writting will be highlighted
%   (Only available in R14 or higher). The actual working MATLAB Version
%   will be also captured. If user forgot to enter code and execute the
%   function, he will get a reminder to enter code in the function.
%
%   NEWFCN, NEWSL, NEWXPC and NEWFCN_RENAME are a set of M-Functions which
%   shold help the MATLAB User to create Functions, Simulink and xPC Target
%   based Models in a quick Way.
% 
%   These Files are shared for all Users in :
%   http://www.mathworks.com/matlabcentral/fileexchange Syntax :  
%   >> newfcn M_FcnName  or  >> newfcn('M_FcnName')
%
%   Example :
%   ---------
%   >> newfcn dummy
%
%   %%%%%%%%%% BEGINN CODE %%%%%%%%%%
%      function dummy()
%      % DUMMY ... 
%      %  
%      %   ... 
%      
%      %% AUTHOR    : Frank Gonzalez-Morphy 
%      %% $DATE     : 15-Jul-2004 15:36:42 $ 
%      %% $Revision : 1.00 $ 
%      %% DEVELOPED : 7.0.0.19920 (R14)
%      %% FILENAME  : dummy.m 
%      
%      disp(' !!!  You must enter code into this file < dummy.m > !!!') 
%      
%      % Created with NEWFCN.m by Frank Gonzalez-Morphy  
%      % ... mailto: frank.gonzalez-morphy@mathworks.de  
%      % ===== EOF ====== [dummy.m] ======  
%      
%   %%%%%%%%%% CODE - END  %%%%%%%%%%
%
%   See also: NEWFCN_RENAME NEWSL NEWXPC 

%% AUTHOR    : Frank Gonzalez-Morphy 
%% $DATE     : 18-Dec-2001 16:46:44 $ 
%% $Revision : 1.30 $ 
%% FILENAME  : newfcn.m 

%% MODIFICATIONS:
%% $26-Sep-2002 14:44:35 $
%% Developent point added, to be know, under which version of
%% MATLAB the new Fcn generated was [Line:80]
%% ---
%% $25-Feb-2002 07:29:17 $ 
%% change BREAK to RETURN after Warning message of R13B2: 
%% "A BREAK statement appeared outside of a loop.  This BREAK ..."
%% "is interpreted as a RETURN."
%% ----
%% $17-Jun-2004 15:12:55 $ 
%% Add version checking for R14 and accessing OPENTOLINE from codepad
%% See Lines from 103 till 109
%% changed Line 77 to 'version'
%% ----
%% $15-Jul-2004 15:20:50 $
%% Add Originlines and wrote comments for release it at MATLABcentral.
%% 

if nargin == 0, help(mfilename); return; end
if nargin > 1, error('  MSG: Only one Parameter accepted!'); end


ex = exist(fcnname);  % does M-Function already exist ? Loop statement
while ex == 2         % rechecking existence
    overwrite = 0;    % Creation decision
    msg = sprintf(['Sorry, but Function -< %s.m >- does already exist!\n', ...
        'Do you wish to Overwrite it ?'], fcnname);
    % Action Question: Text, Title, Buttons and last one is the Default
    action = questdlg(msg, ' Overwrite Function?', 'Yes', 'No','No');
    if strcmp(action,'Yes') == 1
        ex = 0; % go out of While Loop, set breaking loop statement
    else
        % Dialog for new Functionname
        fcnname = char(inputdlg('Enter new Function Name ... ', 'NEWFCN - New Name'));
        if isempty(fcnname) == 1  % {} = Cancel Button => "1"
            disp('   MSG: User decided to Cancel !')
            return
        else
            ex = exist(fcnname);  % does new functionname exist ?
        end
    end
end

overwrite = 1;

if overwrite == 1
    CreationMsg = CreateFcn(fcnname);   % Call of Sub-Function
    disp(['   MSG: <' fcnname '.m> ' CreationMsg])
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%   CREATEFCN   %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function s = CreateFcn(name)

pth = fullfile(getenv('HOME'), 'MATLAB-Drive', 'mfiles', '');
ext = '.m'; 
filename = fullfile(pth, [name ext]);

fid = fopen(filename,'w');

line_1 = ['function ',name,'()']; % Function Header

h1 = ['%% ', upper(name), ' ...'];   % HELP-Line's will be preset
h2 =  '%  Args:';
h3 =  '%      arg_name (arg_class):  Description of arg.';
h4 =  '%  Returns:';
h5 =  '%      returned_name:  Description of returned.';
h6 =  '%';

fprintf(fid,'%s\n', line_1);    % First 7 Lines will be write in file
fprintf(fid,'%s\n', h1);       %   "
fprintf(fid,'%s\n', h2);       %   "
fprintf(fid,'%s\n', h3);       %   "
fprintf(fid,'%s\n', h4);       %   "
fprintf(fid,'%s\n', h5);       %   "
fprintf(fid,'%s\n', h6);       %   "

% Writer settings will be consructed ...
filenamesaved = filename;     

% Line 8-12 will be write in File ...
fprintf(fid,'%%  Created %s by %s in repository\n', datestr(now), getenv('USER'));
fprintf(fid,'%%  %s.\n', pth);
fprintf(fid,'%%  Developed on Matlab %s for %s.  Copyright %i John J. Lee.\n\n', version, computer, datetime('today').Year);

% Reminder that user must enter code in created File / Function
lst = 'error(''!!!  You must enter code into this file <';
lst_3 = '> !!!'')';
fprintf(fid,'%s %s.m %s \n', lst, name, lst_3);

% Before last line, from where functionality does come
originl1 = '% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de)';
fprintf(fid,'\n\n\n%s \n', originl1);

% Last Line in the Fcn
end_of_file = ['% ===== EOF ====== [', filenamesaved, '] ====== '];
fprintf(fid,'%s \n', end_of_file);
    
% Close the written File
st = fclose(fid);

if st == 0  % "0" for successful
    % Open the written File in the MATLAB Editor/Debugger
    v = version;
    if v(1) == '7'                 % R14 Version
        opentoline(filename, 12);  % Open File and highlight the start Line
    else
        % ... for another versions of MATLAB
        edit(filename);
    end
    s = 'successfully done !!';
else
    s = ' ERROR: Problems encounter while closing File!';
end

% ===== EOF ===== [newfcn.m] ======
