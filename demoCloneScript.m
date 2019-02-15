%% HOW TO CREATE A COPY OF A HANDLES OBJECT
% This script uses the class definition TestClass to create instances of
% TestClass and to clone its instances.
%
% Written by Sam Oliver & Bobby Nedelkovski
% The MathWorks Australia Pty Ltd
% Copyright 2009, The MathWorks, Inc.

%% CREATE A CLONE - USING METHOD
% This procedure requires you to explicitly create a placeholder in memory
% for cloning the original object.

% Clear any class definitions in memory
clear classes

% Create two instances of TestClass
a = TestClass();
b = TestClass();

% Change the parameters in object 'a'
a.sam   = 5;
a.bobby = 10;

% Confirm that the parameters in object 'b' are not changed
% a.sam   = 5;
% a.bobby = 10;
% b.sam   = 1;
% b.bobby = 2;
a
b

% Call the copy object method to create a clone of 'a' using 'b'
copyobj(a,b);
% a.copyobj(b);  % Can use this syntax instead

% Check the parameter values for 'a' and 'b' are the same
% a.sam   = 5;
% a.bobby = 10;
% b.sam   = 5;
% b.bobby = 10;
a
b

% Change the parameters in object 'a' again
a.sam   = 500;
a.bobby = 1000;

% Confirm the clone (or deep copy) is successfull by comparing 'a' and 'b'
% a.sam   = 500;
% a.bobby = 1000;
% b.sam   = 5;
% b.bobby = 10;
a
b

%% ANOTHER WAY TO CLONE - USING CONSTRUCTOR
% This procedure implicitly creates a placeholder in memory
% for cloning the original object by way of the constructor.

clear classes

% Create an object of TestClass
a = TestClass();

% Change the parameters in object 'a'
a.sam   = 5;
a.bobby = 10;

% Create a clone (or deep copy) of object 'a'
b = TestClass(a);

% Check the parameter values for 'a' and 'b' are the same
% a.sam   = 5;
% a.bobby = 10;
% b.sam   = 5;
% b.bobby = 10;
a
b

% Change the parameters in object 'a' again
a.sam   = 500;
a.bobby = 1000;

% Confirm the clone (or deep copy) is successfull by comparing 'a' and 'b'
% a.sam   = 500;
% a.bobby = 1000;
% b.sam   = 5;
% b.bobby = 10;
a
b
