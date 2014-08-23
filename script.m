clc; clear all;

%set options
trainfile = 'train.dat';
testfile = 'test.dat';
identifier = 'expPrefix';


% read data
disp('Reading data');
matfile = strcat(identifier, '.mat');
readdata(trainfile, testfile, matfile);


% Non Linear Transform
disp('Non Linear transform');
gammalist = [0.001, 0.01,0.1,1,10,100, 1000];
expandbasis(matfile, identifier, gammalist, 6);


% Rect and Rahimi transform
disp('Rect and Rahimi transform');
gammainvlist = [10, 50, 100, 250, 500, 1000];
n_randomfeatureslist = [100, 200, 500, 1000];
rectandrahimi(matfile, identifier, gammainvlist, n_randomfeatureslist);

