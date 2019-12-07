function [fL, fD, fLl, fDl, fLh, fDh, time, solution, timeL, solutionL, timeH, solutionH, solutionPID, solutionPIDhigh, solutionPIDlow] = computeResults_OPT(rudderArray, liftArray, dragArray, accuracy, invM, D, omega, control_function, timespan, dt, X0, Kp,Ki, Kd, desiredAngle)
%computeResults_OPT The business logic of the simulator (optimized version)
%   This function corresponds to the core of the simulator and implements
%   its business logic. It takes the acquired data as an input and outputs
%   the data that can be used to visualize the results.

[fL, fD] = findCoefficient(rudderArray, liftArray, dragArray, 0);
[fLl, fDl] = findCoefficient(rudderArray, liftArray, dragArray, accuracy/2);
[fLh, fDh] = findCoefficient(rudderArray, liftArray, dragArray, -accuracy/2);

[time, solution] = ode45(@(t, X) systemODE_OPT(t, X, invM, D, omega, control_function, 1, true, fL, fD), timespan, X0); 
solution = solution';

[timeL, solutionL] = ode45(@(t, X) systemODE_OPT(t, X, invM, D, omega, control_function, 1, true, fLl, fDl), timespan, X0); 
solutionL = solutionL';

[timeH, solutionH] = ode45(@(t, X) systemODE_OPT(t, X, invM, D, omega, control_function, 1, true, fLh, fDh), timespan, X0); 
solutionH = solutionH';

solutionPID = RungeKuttaPID(Kp,Ki, Kd, desiredAngle, timespan, X0, invM, D, omega, control_function, fL, fD, dt);
solutionPIDhigh = RungeKuttaPID(Kp,Ki, Kd, desiredAngle, timespan, X0, invM, D, omega, control_function, fLh, fDh, dt);
solutionPIDlow = RungeKuttaPID(Kp,Ki, Kd, desiredAngle, timespan, X0, invM, D, omega, control_function, fLl, fDl, dt);
end

