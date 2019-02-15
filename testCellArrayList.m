%% Test Script for Class mlpatterns.CellArrayList
% Step through and execute this script cell-by-cell to verify a cell array
% implementation of the List Abstract Data Type (ADT).
%
% Written by Bobby Nedelkovski
% MathWorks Australia
% Copyright 2009-2010, The MathWorks, Inc.


%% Clean Up
clear classes
clc


%% Create Instance of CellArrayList
myList = mlpatterns.CellArrayList();


%% Check Number of Elements
% empty = 1
% len = 0
empty = myList.isempty()
len = myList.length()


%% Append Arbitrary Elements to End of List
myList.add(5);        % a single integer
myList.add(rand(2));  % a 2x2 matrix
myList.add({50,55});  % 2 integers as 2 unique elements


%% Check Number of Elements
% empty = 0
% len = 4
empty = myList.isempty()
len = myList.length()


%% Display 'myList'
% Alternatively, you can execute "myList.display()" which produces the same
% output.
myList


%% Seek an Element
% count = 1
% location = 3
count = myList.countOf(50)
location = myList.locationsOf(50)


%% Insert Elements in Arbitrary Locations
myList.add({rand(3),5:7},2);  % a 3x3 matrix and a 1x3 array
myList.add(myList,5);         % reference to self!


%% Display 'myList'
% Alternatively, you can execute "myList.display()" which produces the same
% output.
myList


%% Insert Elements in Arbitrary Locations
myList.add({10,11;12,13},6);  % a 2x2 cell array
myList.add({150,160,170},4);  % 3 integers as 3 unique elements


%% Display 'myList'
% Alternatively, you can execute "myList.display()" which produces the same
% output.
myList


%% Check Number of Elements
% len = 11
len = myList.length()


%% Retrieve Elements
elt = myList.get(4)  % elt = 150
elt = myList.get(7)  % elt = 2x2 rand matrix
elt = myList.get(9)  % elt = 2x2 cell array


%% Retrieve Multiple Elements
% elts = {150;160;3x3 rand matrix}
elts = myList.get([4:5,2])


%% Add Duplicate Element
myList.add(5,7);

%% Seek an Element
% count = 2
% locations = [1;7]
count = myList.countOf(5)
locations = myList.locationsOf(5)


%% Try to Remove Elements
% This yields an empty set [ ] since myList.length()=12 (refer to the
% specification for remove() in the List abstract class)
elts = myList.remove([5:6,20])


%% Remove Some Elements
% elts = {160;170;reference to self}
elts = myList.remove([5:6,9])


%% Check Number of Elements
% len = 9
len = myList.length()


%% Remove All Elements
elts = myList.remove(1:myList.length())


%% Check Number of Elements
% empty = 1
% len = 0
empty = myList.isempty()
len = myList.length()


%% Create an Array of CellArrayLists
% Gives a 2x2 CellArrayList
myList(2,2) = mlpatterns.CellArrayList();


%% Add Elements to All Lists
myList.add({rand(3),5:7},2);  % a 3x3 matrix and a 1x3 array
myList.add(500,5);            % a single integer


%% Display 'myList'
% Alternatively, you can execute "myList.display()" which produces the same
% output.
myList


%% Add Elements to 2 Lists
myList(:,1).add({99,100});  % 2 integers


%% Check Number of Elements
% len = [5,3; 5,3]
len = myList.length()


%% Insert Element to 2 Lists in Location 4
myList(1,:).add(rand(2),4);  % a 2x2 rand matrix


%% Display 'myList'
% Alternatively, you can execute "myList.display()" which produces the same
% output.
myList


%% Check Number of Elements
% len = [6,4; 5,3]
len = myList.length()


%% Append Element to Single List
myList(2,1).add(99);  % an integer


%% Check Number of Elements
% len = [6,4; 6,3]
len = myList.length()


%% Seek an Element
% count = [1,0; 2,0]
% locations = {5,[ ]; [4;6],[ ]}
count = myList.countOf(99)
locations = myList.locationsOf(99)


%% Remove Some Elements
% elts = {{2x2 rand matrix; 99},[ ]; {99; 100},[ ]}
elts = myList.remove([4,5])
elts{1,1}
elts{2,1}


%% Display 'myList'
% Alternatively, you can execute "myList.display()" which produces the same
% output.
myList

