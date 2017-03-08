function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%
%pval is the probability density 
bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

  %use the cross validation set to select the parameter epsilon
 % cal the true positive, false positive, false negative
predictions = (pval < epsilon);
tp = sum(predictions .* yval,1);
fp = sum((~predictions) .* yval,1);
fn = sum(predictions .* (~yval),1);
    if (tp + fp ) > 0 && (tp + fn) >0 ;
       % cal the precision -- true positive /(true positive + false positive)
          precision = tp / ( tp + fp);
       % cal the recall -- true positive / (true positive + false negative)
          recall  = tp / (tp + fn);
       % cal the F score  2*(precision * recall)/(precision + recall)
          F1 = 2 * precision * recall / ( precision + recall);
       
          % =============================================================
    else
      F1 = 0;
    end
    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
