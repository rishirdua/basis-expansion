function expandbasis(matfilename, outfileprefix, gammalist, n)


%% DESCRIPTION %%

% Expands each feature I with 1 <= I <= n_features as a vector of n features as
% exp(-\gamma x_i^2) .* [1, z, (z^2)/sqrt(2!), (z^3)/sqrt(3!) , …, (z^n)/sqrt(n!)]
% where z= \sqrt(2*\gamma) x_i
% For any given n you will now get a vector of size n_features*(n+1).
% Does this for k = 1, 2, 3, ... n


%read
load (matfilename);

% train file
n_features = size(xTrain,2);
n_data = size(xTrain,1);
outfilesuffix = 'train';

disp('Processing training data');

for gamma = gammalist,
	disp(gamma);

	for k=1:n,
		fout{k}= strcat([outfileprefix, '_nlt_', num2str(k),'_',num2str(gamma),'_',outfilesuffix],'.dat');
	end

	%calculate
	factor1 = abs(sign(xTrain)).*exp(-gamma*(xTrain.*xTrain)); 
	factor = exp(-gamma*(xTrain.*xTrain));
	Data_new =  [factor1, factor.* (sqrt(2*gamma).*xTrain), factor.* ((sqrt(2*gamma).*xTrain).^2) / sqrt(factorial(2)), factor.* ((sqrt(2*gamma).*xTrain).^3) / sqrt(factorial(3)), factor.* ((sqrt(2*gamma).*xTrain).^4) / sqrt(factorial(4)), factor.* ((sqrt(2*gamma).*xTrain).^5) / sqrt(factorial(5)), factor.* ((sqrt(2*gamma).*xTrain).^6) / sqrt(factorial(6))];
	disp('calculated');

	%normalize
	%mean_tr = mean(Data_new);
	%std_tr = std(Data_new);
	%Data_new = (Data_new-repmat(mean_tr,n_data,1))./(repmat(std_tr,n_data,1));
	%disp('normalized');

	%write
	Data_new = sparse(Data_new);
	for k=n:-1:1,
		libsvmwrite(fout{k}, yTrain, sparse(Data_new));
		Data_new = Data_new(:,1:k*n_features);
		disp('writen to file');
	end;
end;

%test file
n_features = size(xTrain,2);
n_data = size(xTrain,1);
outfilesuffix = 'test';

disp('Processing test data');

for gamma = gammalist
	disp(gamma);

	for k=1:n,
		fout{k} = strcat([outfileprefix, '_nlt_', num2str(k),'_',num2str(gamma),'_',outfilesuffix],'.dat');
	end

	%calculate
	factor1 = abs(sign(xTest)).*exp(-gamma*(xTest.*xTest)); 
	factor = exp(-gamma*(xTest.*xTest));
	Data_new =  [factor1, factor.* (sqrt(2*gamma).*xTest), factor.* ((sqrt(2*gamma).*xTest).^2) / sqrt(factorial(2)), factor.* ((sqrt(2*gamma).*xTest).^3) / sqrt(factorial(3)), factor.* ((sqrt(2*gamma).*xTest).^4) / sqrt(factorial(4)), factor.* ((sqrt(2*gamma).*xTest).^5) / sqrt(factorial(5)), factor.* ((sqrt(2*gamma).*xTest).^6) / sqrt(factorial(6))];
	disp('calculated');

	%normalize
	%mean_tr = mean(Data_new);
	%std_tr = std(Data_new);
	%Data_new = (Data_new-repmat(mean_tr,n_data,1))./(repmat(std_tr,n_data,1));
	%disp('normalized');

	
	%write
	for k=n:-1:1,
		libsvmwrite(fout{k}, yTest, sparse(Data_new));
		Data_new = Data_new(:,1:k*n_features);
		disp('writen to file');
	end;
	disp('writen to file');
end;