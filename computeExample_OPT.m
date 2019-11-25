% Script to run the simulation with predefined parameters

% Plot T0
plotForceAgainstShaftSpeed(-132, 132, 0.1, 147000, 165000);

% Plot trajectory
omega = rpmToHz(100); % Initial omega = 100 rpm (= 100/60 Hz)

X0 = [0 0 0 0 0 0]'; % Initial state

M = [11 0 0; 0 11 8.4; 0 8.4 5800] * 10^6; % mass matrix
D = [3 0 0; 0 5.5 6.4; 0 6.4 1200] * 10^5; % linear damping matrix

dt = 0.1; % timestep
timespan = 0:dt:1000; % simulation interval [s]

invM = inv(M); % inverse of the linear damping matrix (calculated before to reduce computational complexity later)

syms control_signal(t)
control_signal = 30*sin(0.06*t); % rudder movement
%disturbance_signal = 30*sin(100*t) + 30*sin(90*t); % disturbance

control_function = matlabFunction(control_signal);

[fL, fD] = findCoefficient([-45, -40, -30, -20, -10, 0, 10, 20, 30, 40, 45], [-0.46, -0.48, -0.46, -0.38, -0.2, 0, 0.2, 0.38, 0.46, 0.48, 0.46], [0.78, 0.68, 0.48, 0.22, 0.08, 0.02, 0.08, 0.22, 0.48, 0.68, 0.78]);

[time, solution] = ode45(@(t, X) systemODE_OPT(t, X, invM, D, omega, control_function, 1, true, fL, fD), timespan, X0); 
solution = solution';

desiredAngle = pi/6; % desired heading angle; 30 degrees --> pi/6 rad

% PID parameters
Kp = 10;
Ki = 0.001;
Kd = 0.001;

solutionPID = zeros(6, length(timespan)); % the initial solution matrix (dimension timespan x 6) is filled with 0s.
solutionPID(:,1) = X0; % the initial state is X0 ([0 0 0 0 0 0]')
PID = zeros(size(timespan)); % the PID effect is also inizialized to zero for the first iteration (there is no backpropagation yet)

e_previous = 0;
e_int = 0;

%%% 4th order Runge-Kutta method
for i=1:length(timespan)-1
    %e = deg2rad(control_function(timespan(i))) - solutionPID(3,i) + desiredAngle; % error (INPUT - OUTPUT + desiredAngle)
    e = desiredAngle - solutionPID(3,i); % error (desiredAngle - OUTPUT)

    e_int = e_int + e; % discrete integration
    
    PID(i) = Kp*e + Ki*e_int*dt + Kd*(wrapTo2Pi(e - e_previous))/dt; % PID function (discrete)
    e_previous = e;
        
    % Setting of RK parameters
    K1 = systemODE_OPT(timespan(i), solutionPID(:,i), invM, D, omega, control_function, PID(i), false, fL, fD);
    K2 = systemODE_OPT(timespan(i)+ 0.5*dt, solutionPID(:,i)+0.5*dt*K1, invM, D, omega, control_function, PID(i), false, fL, fD);
    K3 = systemODE_OPT(timespan(i)+ 0.5*dt, solutionPID(:,i)+0.5*dt*K2, invM, D, omega, control_function, PID(i), false, fL, fD);
    K4 = systemODE_OPT(timespan(i)+ dt, solutionPID(:,i)+ dt*K3, invM, D, omega, control_function, PID(i), false, fL, fD);

    solutionPID(:,i+1) = solutionPID(:,i) + dt*(K1/6 + K2/3 + K3/3 + K4/6); % Discrete step
end
    
% Figure plot

%Heading
figure(2)
hold on
plot(time, wrapTo2Pi(solution(3,:)));

title('Heading with respect to time')
xlabel('Time [s]')
ylabel('Heading [rad]')
grid on
hold on
plot(time, solutionPID(3,:));

hold on
fplot(desiredAngle, 'k.')
legend('Without PID','With PID','Objective heading')

hold off


% Trajectory
figure(3);
axis equal tight
hold on
plot(solution(2,:), solution(1,:));
title('Ship trajectory')
xlabel('y_W [m]')
ylabel('x_W [m]')
grid on

hold on
plot(solutionPID(2,:), solutionPID(1,:));

hold on
fplot(@(t) tan(pi/2 - desiredAngle)*t, 'k.')
legend('Without PID','With PID','Objective trajectory')

hold off