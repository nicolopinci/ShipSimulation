function [control_function, rudderArray, liftArray, dragArray, accuracy, invM, timespan, dt, M, D, X0, omega, Kp, Ki, Kd, desiredAngle] = acquireData()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


omega = rpmToHz(100); % Initial omega = 100 rpm (= 100/60 Hz)

X0 = [0 0 0 0 0 0]'; % Initial state

M = [11 0 0; 0 11 8.4; 0 8.4 5800] * 10^6; % mass matrix
D = [3 0 0; 0 5.5 6.4; 0 6.4 1200] * 10^5; % linear damping matrix

dt = 0.1; % timestep
timespan = 0:dt:1000; % simulation interval [s]

invM = inv(M); % inverse of the linear damping matrix (calculated before to reduce computational complexity later)

syms control_signal(t)
control_signal = 30*sin(0.06*t); % rudder movement

control_function = matlabFunction(control_signal);

[rudderArray, liftArray, dragArray, accuracy] = getCoefficientData();

% PID parameters
Kp = 10;
Ki = 0.05;
Kd = 0.0001;

desiredAngle = pi/6; % desired heading angle; 30 degrees --> pi/6 rad


end

