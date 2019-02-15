%% $Id$

% http://stackoverflow.com/questions/1792838/how-do-i-enable-ident-string-for-git-repos/1796675#1796675
% You can do this by adding a pattern for which files you want this functionality followed by ident in the .gitattributes file. This will replace $Id$ with $Id$ on checkout of the file. Notice though that it won't give you a revision number of the file as in CVS/SVN.

% Example:

% $ echo '*.txt ident' >> .gitattributes
% $ echo '$Id$' > test.txt
% $ git commit -a -m "test"

% $ rm test.txt
% $ git checkout -- test.txt
% $ cat test.txt
% Link to gitattributes(5) Manual Page
% https://git-scm.com/docs/gitattributes#_tt_ident_tt

function test_gitattributes()
	fprintf('testing use of identifer keyword and its expansion $Id$\n');
end
