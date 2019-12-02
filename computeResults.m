function [time, solution, timeL, solutionL, timeH, solutionH, solutionPID, solutionPIDhigh, solutionPIDlow] = computeResults(rudderArray, fL,fD, fLl,fDl, fLh,fDh, invM, D, omega, control_function, timespan, dt, X0, Kp,Ki, Kd, desiredAngle)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


[time, solution] = ode45(@(t, X) systemODE(t, X, invM, D, omega, control_function, 1, true, 1), timespan, X0); 
solution = solution';

[timeL, solutionL] = ode45(@(t, X) systemODE(t, X, invM, D, omega, control_function, 1, true, 0), timespan, X0); 
solutionL = solutionL';

[timeH, solutionH] = ode45(@(t, X) systemODE(t, X, invM, D, omega, control_function, 1, true, 2), timespan, X0); 
solutionH = solutionH';

visualizeInterpolation(rudderArray, fLl, fLh, fL, 2, 'f_L');
visualizeInterpolation(rudderArray, fDl, fDh, fD, 3, 'f_D');

solutionPID = RungeKuttaPID(Kp,Ki, Kd, desiredAngle, timespan, X0, invM, D, omega, control_function, fL, fD, dt);
solutionPIDhigh = RungeKuttaPID(Kp,Ki, Kd, desiredAngle, timespan, X0, invM, D, omega, control_function, fLh, fDh, dt);
solutionPIDlow = RungeKuttaPID(Kp,Ki, Kd, desiredAngle, timespan, X0, invM, D, omega, control_function, fLl, fDl, dt);

end

