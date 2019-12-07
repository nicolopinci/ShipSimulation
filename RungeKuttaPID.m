function solutionPID = RungeKuttaPID(Kp,Ki, Kd, desiredAngle, timespan, X0, invM, D, omega, control_function, fL, fD, dt)
%RungeKuttaPID This function returns the solutions of the feedback system
%in case the PID controller is inserted.
%   The simulation has been performed by using the 4th order Runge-Kutta
%   method.

solutionPID = zeros(6, length(timespan)); % the initial solution matrix (dimension timespan x 6) is filled with 0s.
solutionPID(:,1) = X0; % the initial state is X0 ([0 0 0 0 0 0]')
PID = zeros(size(timespan)); % the PID effect is also inizialized to zero for the first iteration (there is no backpropagation yet)

e_previous = 0;
e_int = 0;

%%% 4th order Runge-Kutta method
for i=1:length(timespan)-1
   
    e = solutionPID(3,i)-desiredAngle; % error (desiredAngle - OUTPUT)

    e_int = e_int + e; % discrete integration
    
    PID(i) = Kp*e + Ki*e_int*dt + Kd*(e - e_previous)/dt; % PID function (discrete)
    e_previous = e;
        
    % Setting of RK parameters
    K1 = systemODE_OPT(timespan(i), solutionPID(:,i), invM, D, omega, control_function, PID(i), false, fL, fD);
    K2 = systemODE_OPT(timespan(i)+ 0.5*dt, solutionPID(:,i)+0.5*dt*K1, invM, D, omega, control_function, PID(i), false, fL, fD);
    K3 = systemODE_OPT(timespan(i)+ 0.5*dt, solutionPID(:,i)+0.5*dt*K2, invM, D, omega, control_function, PID(i), false, fL, fD);
    K4 = systemODE_OPT(timespan(i)+ dt, solutionPID(:,i)+ dt*K3, invM, D, omega, control_function, PID(i), false, fL, fD);

    solutionPID(:,i+1) = solutionPID(:,i) + dt*(K1/6 + K2/3 + K3/3 + K4/6); % Discrete step
end
 
end

