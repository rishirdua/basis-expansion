function rectandrahimi(matfilename, outfileprefix, gammainvlist, n_randomfeatureslist)


%% DESCRIPTION


% Transforms features into Recht and Rahimi’s Random Fourier Feature as defined in:
Rahimi, Ali, and Benjamin Recht. "Random features for large-scale kernel machines." In Advances in neural information processing systems, pp. 1177-1184. 2007.


%read
load (matfilename);
n_features = size(xTrain,2);
n_traindata = size(xTrain,1);
n_testdata = size(xTest,1);

for gamma_inv = gammainvlist
	gamma = 1/gamma_inv;
	disp('Current value of gamma_inv');
	disp(gamma_inv);
	sigma = sqrt(2/gamma_inv);
	for n_randomfeatures = n_randomfeatureslist
		ftrainout = strcat([outfileprefix, '_rrt_', num2str(n_randomfeatures),'_',num2str(gamma_inv),'_train.dat']);
		ftestout = strcat([outfileprefix, '_rrt_', num2str(n_randomfeatures),'_',num2str(gamma_inv),'_test.dat']);
		%calculate
		W=normrnd(0,sigma,n_features,n_randomfeatures);
		b=2*pi*rand(1,n_randomfeatures);
		Btrain = ones(n_traindata,1)*(b);
		Btest = ones(n_testdata,1)*(b);
		xTrain_new = sqrt(2/n_randomfeatures)*cos(xTrain*W+Btrain);
		xTest_new = sqrt(2/n_randomfeatures)*cos(xTest*W+Btest);
		disp('calculated');
		
		%normalize
		%mean_tr = mean(Data_new);
		%std_tr = std(Data_new);
		%Data_new = (Data_new-repmat(mean_tr,n_data,1))./(repmat(std_tr,n_data,1));
		%disp('normalized');
		%toc;

		%write
		libsvmwrite(ftrainout, yTrain, sparse(xTrain_new));
		libsvmwrite(ftestout, yTest, sparse(xTest_new));
		disp('writen to file');
	end;
end;