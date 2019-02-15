function newfcn_rename(oldname,newname)
% NEWFCN_RENAME is a function which help to rename completely a function
%  
%   NEWFCN_RENAME is a helper function which helps you not only to rename
%   the filename, also the different name labels inside the function. 
%   In specialy these file works for created Functions with NEWFCN.m 
%     You must provide first the Filename which should be renamed and as
%   second parameter the new File- and Functionname.
%     NOTE: To be able to use these Function to rename a Function, it must
%   have at least (see also Example below):
%     * Function Name Header
%     * Help Header in upper characters
%     * The Filename under is saved
%     * End of File Filename label
%
%   NEWFCN, NEWSL, NEWXPC and NEWFCN_RENAME are a set of M-Functions which
%   shold help the MATLAB user to create Functions, Simulink and xPC Target
%   based Models in a quick way.
%
%   Syntax: >> newfcn_rename('OldFcnName','NEWFcnName')
%          >> newfcn_rename OldFcnName NEWFcnName
% 
%   See also: NEWFCN NEWSL NEWXPC
%
%   Example:
%   =========== >> newfcn dummy ===============================
%      function dummy()
%      % DUMMY ...
%  
%      %% FILENAME  : dummy.m
%  
%      % [snip]
%      % ===== EOF ====== [dummy.m] ======
%   ===========================================================
% 
%   =========== >> newfcn_rename dummy new_fcn_name ===========
%      function new_fcn_name()
%      % NEW_FCN_NAME ... 
% 
%      %% FILENAME  : new_fcn_name.m 
% 
%      % [snip]
%      % ===== EOF ====== [new_fcn_name.m] ======  
%   ===========================================================
% 


%% AUTHOR    : Frank Gonzalez-Morphy 
%% $DATE     : 25-Jul-2004 20:53:26 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 7.0.0.19920 (R14) 
%% FILENAME  : newfcn_rename.m 


if nargin == 0, help(mfilename); return, end
if nargin == 1
    error('   MSG: You must enter at least the New Functionname!')
end

try
    newname = CheckIfFileExists(newname);
catch
    error('  MSG: NEWFCN_RENAME:CheckIfFileExists - After rechecking run again!')
end

ext_mfile = '.m';
oldname_ext = [oldname ext_mfile];
newname_ext = [newname ext_mfile];

% Open File for Read content
fid = fopen(oldname_ext, 'r');
% Scaned_File = fread(fid, '*char')
Scaned_File   = fscanf(fid, '%c', inf);
fclose(fid);

% Modified_File = Scaned_File;

% Different Sizes of the Names
% ... OLD
sz_old     = size(oldname,2);
sz_old_ext = size(oldname_ext,2);
% ... NEW
sz_new     = size(newname,2);
sz_new_ext = size(newname_ext,2);
% Upper Filenames
oldname_U = upper(oldname);
newname_U = upper(newname);

% Position of function Header
Start_Pos_fH  = findstr([oldname '('], Scaned_File);
% Start_Pos_fH  = Start_Pos_fH(1); % (1) because we have 3 OldNames in File
% Renaming function Header
Modified_File = [Scaned_File(1,1:Start_Pos_fH-1) newname, ...
    Scaned_File(1,Start_Pos_fH+sz_old:end)];

% Position of upper Help Header
Start_Pos_uHH = findstr(oldname_U, Modified_File);
% Renaming upper Help Header
Modified_File = [Modified_File(1,1:Start_Pos_uHH-1) newname_U, ...
    Modified_File(1,Start_Pos_uHH+sz_old:end)];

% Position of Filename Line
Start_Pos_ext = findstr(oldname_ext, Modified_File);
Start_Pos_FN  = Start_Pos_ext(1);  % (1) because we have 2 *.m Name labels
% Renaming Filename Line
Modified_File = [Modified_File(1,1:Start_Pos_FN-1) newname_ext, ...
    Modified_File(1,Start_Pos_FN+sz_old_ext:end)];

% Position of EOF Line
Start_Pos_ext = findstr(oldname_ext, Modified_File);
Start_Pos_EOF = Start_Pos_ext(end);  % if there are more name in between
% Renaming EOF Line
Modified_File = [Modified_File(1,1:Start_Pos_EOF-1) newname_ext, ...
    Modified_File(1,Start_Pos_EOF+sz_old_ext:end)];


% Delete the old Function File
delete(oldname_ext);
% Open File for Writing 
fid = fopen(newname_ext, 'w+');
% Create and Write content into the File
fprintf(fid, '%s', Modified_File);
% fprintf(fid, '%c', Modified_File);
st = fclose(fid);
if st == 0
    disp(['   MSG: <' oldname '.m> renamed in :'])
    disp(['   MSG: <' newname '.m> successfuly renamed!'])
    edit(newname_ext);  % Edit the new Function on the Editor
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%    CheckIfFileExists    %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function notexisting = CheckIfFileExists(fcnname)
% Sub-Function does check if File exist already, if so ask for overriding
% it or maybe save it under another name.

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
            error('   MSG: User decided to Cancel !')
        else
            ex = exist(fcnname);  % does new functionname exist ?
        end
    end
end
overwrite = 1;
if overwrite == 1
    notexisting = fcnname;
end

% Created with NEWFCN.m by Frank González-Morphy  
% Contact...: frank.gonzalez-morphy@mathworks.de  
% ===== EOF ====== [newfcn_rename.m] ======  
