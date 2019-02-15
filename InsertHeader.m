function InsertHeader(varargin)
% InsertHeader - Adds a template to the top of current file in editor for documentation.
% 
% Syntax: InsertHeader()
%   Example 1:  InsertHeader adds header to top of currently selected file in
%   editor
%   Example 2: InsertHeader('InsertHeader') added the current header information to this
%   file. NOTE:  THIS CANNOT BE UNDONE!  THE FIRST TIME YOU USE THIS, PLEASE
%   HAVE A BACK UP COPY OF THE FILE IN CASE IT MAKES A MISTAKE.
%   Custom defined headers can be created in the subfunction defined at
%   the end of the file.  I wish to express thanks to the authors of tedit.m and
%   newfcn.m which helped me to create this routine.
%  See also:  tedit, newfcn
% Subfunctions: EditorCurrentFile, insertHeaderTemplateFile
%   See also: 

%% AUTHOR    : Dan Kominsky
% $Date:  $
% $Revision:  $
% $RCSfile:  $
% Copyright 2006  Prime Research, LC.
%%

if nargin==1
	CurrentFile=varargin{1};
else
	% Call subfunction to determine the current file:
	[CurrentFile]=EditorCurrentFile;
end
% Ask to make sure I am going to add the header to the correct file
resp=questdlg(['Add Header to file: ' CurrentFile '?'],'Header Query');
if ~strcmpi(resp,'Yes'),return;end;

% Define the handle for the java commands:
edhandle=com.mathworks.mlservices.MLEditorServices;
% Save the current document so changes aren't lost
edhandle.saveDocument(CurrentFile);
[PATH,FILENAME]=fileparts(CurrentFile);

% Load the existing file
rawText=char(edhandle.builtinGetDocumentText(CurrentFile));
% For some reason the previous command replaces (at least on windows) each
% carraige return with a carraige return/line feed combo.  The next line removes
% the double spacing.   It may not be necessary on other platforms!
currentText=regexprep(rawText,[char(13) char(10)],char(13));

% Check to find the true end of the first line.  If it is a continuation, keep
% going until the function definition is ended.
ellipsisTest=true;
firstLine='';
remainder=currentText;
while ellipsisTest
	[tmpfirstLine,remainder]=strtok(remainder,char(13));
	firstLine=[firstLine,char(13),tmpfirstLine];
	if sum(firstLine(end-4:end)==46)>=3
		ellipsisTest=true;
	else
		ellipsisTest=false;
	end
	pause(0.01)
end

funcLabel=any(regexp(firstLine,'function'));
syntaxStr={};
inputs={};
outputs={};
count=1;
if funcLabel
	syntaxStr=regexprep(firstLine,'function','');
	hasEquals=any(regexp(syntaxStr,'='));
	if hasEquals
	[beforeEq,afterEq]=strtok(strtrim(syntaxStr),'=');
	else
		beforeEq='';afterEq=strtrim(syntaxStr);
	end
	tmpoutputs=regexp(beforeEq,'(\w+)','tokens');
	for n=1:numel(tmpoutputs)
		outputs{n}=char(tmpoutputs{n});
	end
	tmpinputs=regexp(afterEq,'(\w+)','tokens');
	funcname=char(tmpinputs{1});
	for n=2:numel(tmpinputs)
		inputs{n-1}=char(tmpinputs{n});
	end
end

possibleSubFcns=strfind(remainder,'function');
subFcnName={};
for n=1:length(possibleSubFcns)
	currentChar=possibleSubFcns(n);
	keepGoing=true;
	while keepGoing
		prevChar=currentChar-1;
		if double(remainder(prevChar))==13
			subFcn(n)=true;
			keepGoing=false;
		elseif isspace(remainder(prevChar))
			currentChar=prevChar;
		else
			subFcn(n)=false;
			keepGoing=false;
		end
	end
	if subFcn(n)
		oneline=strtok(remainder(prevChar+1:end),char(13));
		parenCheck=strtok(oneline,'(');
		subFcnName(count)=regexp(parenCheck,'(\w*)$','tokens');
		count=count+1;
	end
end


% insertHeaderTemplateFile contains the text to be added into the file
tmpl=insertHeaderTemplateFile(FILENAME,inputs,outputs,syntaxStr,subFcnName);

% Convert to a string
parseIn = sprintf('%s\n',tmpl{:});


% Concatenate the firstline (function definition), header, and body:
concatenatedText=strcat(firstLine,parseIn,remainder);
% Strip any extra leading carraige returns:
while (double(concatenatedText(1)))==13 || (double(concatenatedText(1)))==10
	concatenatedText(1)=[];
end


% Close the file:
edhandle.closeDocument(CurrentFile);
% Open and OVERWRITE the file
fid=fopen(CurrentFile,'wt');
fprintf(fid,'%s\n',concatenatedText);
fclose(fid);
% Reopen the file to the begining.
edhandle.openDocumentToLine(CurrentFile,1);
end


% ------------------------
function [CurFile,varargout] = EditorCurrentFile

% Define the handle for the set of java commands:
desktopHandle=com.mathworks.mlservices.MatlabDesktopServices.getDesktop;
% Determine the last selected document in the editor:
lastDocument=desktopHandle.getLastDocumentSelectedInGroup('Editor');
% Strip off the '*' which indicates that it has been modified.
CurFile=strtok(char(desktopHandle.getTitle(lastDocument)),'*');

if nargout>1
	varargout{1}=lastDocument;
end
end

%
function tmpl=insertHeaderTemplateFile(FILENAME,varargin)
% insertHeaderTemplateFile Contains the header which is automatically inserted
%   tmpl = insertHeaderTemplateFile(FILENAME)
%
%   Example
%   insertHeaderTemplateFile('currentFile.m') returns the cell array of strings
%   which is inserted into file headers.
%
%   See also

%% AUTHOR    : Dan Kominsky
% $Date:  $
% $Revision:  $
% $RCSfile:  $
% Copyright 2006 Prime Research, LC.
%%
applyComment=@(x)['% ' x ' - Description'];
commaPad=@(x)[x{:}, ', '];

if nargin>1
	inputLines=cellfun(applyComment,varargin{1}','UniformOutput',false);
else
	inputLines='';
end
if nargin>2
	outputLines=cellfun(applyComment,varargin{2}','UniformOutput',false);
else
	outputLines='';
end
if nargin>3
	syntaxStr=['% Syntax: ' strtrim(varargin{3})];
else
	syntaxStr='';
end
subfunlist='';
if nargin>4
	for n=1:length(varargin{4})
		subfunlist=[subfunlist, char(commaPad(varargin{4}{n}))];
	end
	subFcns=['% Subfunctions: ' subfunlist(1:end-2)];
else
	subFcns='% Subfunctions: none';
end
topLines={ ...
	''
  ['% ' FILENAME  ' - One line description of what the function or script performs (H1 line)']
	'% Optional file header info (to give more details about the function than in the H1 line)'};
midLines=[syntaxStr; inputLines;outputLines]
bottomLines={	'%   Example'
	'%  Line 1 of example '
	'%'};
authorLines={...
	'%   See also: '
	''
	'%% AUTHOR    : Jebediah Obediah'
	'% $Date:  $'
	'% $Revision:  $'
	'% $RCSfile:  $'
	['% Copyright ' datestr(now,'yyyy') '  XYZ Corp.']
	'%%'};

tmpl=[topLines;midLines;bottomLines;subFcns;authorLines];
end
%}
