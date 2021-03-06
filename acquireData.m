function [control_function, rudderArray, liftArray, dragArray, accuracy, invM, timespan, dt, M, D, X0, omega, Kp, Ki, Kd, desiredAngle, kp, kn] = acquireData()
%acquireData returns some data that can be used as the properties of the
%system or as the state at the beginning of the simulation.
%   In a real system, data are acquired by using sensors, for instance, or
%   they are stored in a database. Since this simulator does not access
%   real data, this function replaces the data acquisition part in a real
%   world scenario. In case the system is implemented in a real system,
%   the content of this function should be replaced with some functions
%   that are able to get the real data from the sensors.

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
Ki = 0.0001;
Kd = 0.0001;

desiredAngle = pi + pi/6; % desired heading angle; 30 degrees in the world reference frame --> pi/6 rad

end

