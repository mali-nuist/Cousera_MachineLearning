function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
C_arr = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
c_num = size(C_arr,2);
sigma_arr = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
sigma_num = size(sigma_arr,2);
i_flag = 1;
j_flag = 1;
minium_error = 10e10;
for i = 1 : c_num;
  for j = 1 : sigma_num;
    %each combination of C and sigma
      model = svmTrain(X, y, C_arr(i), @(x1, x2) gaussianKernel(x1, x2, sigma_arr(j)));
      predictions = svmPredict(model,Xval);
      error = mean(double(predictions ~= yval));
      if minium_error > error
        minium_error = error;
        i_flag = i;
        j_flag = j;
        bestModel = model;
      end
  end
end
C = C_arr(i_flag);
sigma = sigma_arr(j_flag);
% =========================================================================

end
