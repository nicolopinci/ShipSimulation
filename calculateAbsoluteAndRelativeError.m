function [abs_err,rel_err_perc] = calculateAbsoluteAndRelativeError(solutionPID, desiredAngle)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
abs_err = abs(wrapToPi(wrapTo2Pi(solutionPID) - wrapTo2Pi(desiredAngle)));
rel_err_perc = 100*abs_err/desiredAngle;

end

