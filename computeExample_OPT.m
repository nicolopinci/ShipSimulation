% Script to run the simulation with predefined parameters (optimized
% version)

% Data acquisition
[control_function, rudderArray, liftArray, dragArray, accuracy, invM, timespan, dt, M, D, X0, omega, Kp, Ki, Kd, desiredAngle] = acquireData();

% Business logic
[fL, fD, fLl, fDl, fLh, fDh, time, solution, timeL, solutionL, timeH, solutionH, solutionPID, solutionPIDhigh, solutionPIDlow] = computeResults_OPT(rudderArray, liftArray, dragArray, accuracy, invM, D, omega, control_function, timespan, dt, X0, Kp,Ki, Kd, desiredAngle);

% Presentation
visualizeResults_OPT(rudderArray, fLl, fLh, fL, fDl, fDh, fD, solutionL, solutionH, solution, solutionPIDlow, solutionPIDhigh, solutionPID, desiredAngle, timeL, timeH, time);