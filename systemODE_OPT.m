function dXdt = systemODE_OPT(t, X, invM, D, omega, control_signal, pid, bypassPID, fL, fD)
%systemODE_OPT Function to compute the result of the system that describes the
%dynamic of the system.
%   This function may be used in order to calculate the result of the
%   matrix calculations describing the dynamics of the system. In
%   particular, this may be used both in ode45, when no PID has been set (bypassPID = true) and in
%   Runge-Kutta, when a PID has been inserted (bypassPID = false).
%   t is the current time (from the beginning of the simulation)
%   X is the current status (at time t)
%   invM is the inverse of matrix M
%   D is the damping matrix
%   omega, expressed in Hz, is the shaft angular speed
%   control_signal is the input given to the system (the rudder angle)
%   pid is the input to the ship system and it takes into account the
%   contrl signal, the backpropagation and the desired angle.

phi = wrapTo2Pi(X(3));

if (bypassPID==false)
    delta = pid; % the input of the system is the output of the PID
else
    delta = control_signal(t); % there is no PID, so there is only the control signal
end
 
R = calculateR(phi);

F = get_force_torque_OPT(omega, delta, fL, fD);
F = F';

[A, B] = systemMatrix(R, invM, D, F);

[rA, cA] = size(A);
[rB, cB] = size(B);

if rA~=rB
    error("A and B should have the same number of rows");
end

dXdt = zeros(rA, 1); % fill dXdt with 0s

% compute dX/dt = AX + B
for i=1:rA
    for j=1:cA
        dXdt(i) = dXdt(i) + A(i, j)*X(j);
    end
    for k=1:cB
        dXdt(i) = dXdt(i) + B(i, k);
    end
end