function [abs_err,rel_err_perc] = calculateAbsoluteAndRelativeError(solutionPID, desiredAngle)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
abs_err = abs(solutionPID - desiredAngle);
rel_err_perc = 100*abs_err/desiredAngle;

end

