function [abs_err,rel_err_perc] = calculateAbsoluteAndRelativeError(solutionPID, desiredAngle)
%calculateAbsoluteAndRelativeError This function calculates the absolute
%and relative error with respect to the desired value of a variable.

%   This function calculates the absolute and relative error with respect
%   to the desired value of a variable. For instance, it can be used to
%   calculate the absolute and relative errors for the heading of a ship
%   after having inserted a PID control.

abs_err = abs(wrapToPi(wrapTo2Pi(solutionPID) - wrapTo2Pi(desiredAngle)));
rel_err_perc = 100*abs_err/desiredAngle;

end

