function readdata(trainfile, testfile, outfile)

%example: readdata('unigram_train.dat', 'unigram_train.dat')
[yTrain, xTrain] = libsvmread(trainfile);
[yTest, xTest] = libsvmread(testfile);

if (size(xTrain,2)-size(xTest,2)>0)
	xTrain = full(xTrain);
	xTest = [full(xTest) zeros(size(xTest,1),size(xTrain,2)-size(xTest,2))];
else
	xTrain = [full(xTrain) zeros(size(xTrain,1),size(xTest,2)-size(xTrain,2))];
	xTest = full(xTest);
end
clear trainfile;
clear testfile;
save (outfile);
clear outfile;