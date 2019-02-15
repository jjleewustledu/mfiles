button = questdlg('Ready to quit?', ...
    'Exit Dialog','Yes','No','No');
switch button
    case 'Yes',
        disp('Exiting MATLAB');
        if (exist(                                    'AUTOSAVE_FILE', 'var'))
            setpref('StartupDirectory','LastWorkingDirectory',pwd)
            AUTOSAVE_FILE = [AUTOSAVE_FILE '_D' datestr(now,29)]; %#ok<SUSENS> % time-stamp
            setpref('StartupState','LastWorkingState', AUTOSAVE_FILE)
            disp([  'Saving workspace to '             AUTOSAVE_FILE '...']);
            save(                                      AUTOSAVE_FILE);
        end
    case 'No',
        quit cancel;
end

