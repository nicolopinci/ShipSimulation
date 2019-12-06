% Script to run the simulation with predefined parameters

% Data acquisition
[control_function, rudderArray, liftArray, dragArray, accuracy, invM, timespan, dt, M, D, X0, omega, Kp, Ki, Kd, desiredAngle] = acquireData();
    
% Business logic (and visualization of the interpolation)
[time, solution, timeL, solutionL, timeH, solutionH, solutionPID, solutionPIDhigh, solutionPIDlow] = computeResults(rudderArray,  liftArray, dragArray, accuracy, invM, D, omega, control_function, timespan, dt, X0, Kp,Ki, Kd, desiredAngle);

% Presentation
visualizeResults(solutionL, solutionH, solution, solutionPIDlow, solutionPIDhigh, solutionPID, desiredAngle, timeL, timeH, time);