function F = get_force_torque(omega,delta)
%get_force_torque Summary of this function goes here
%   Detailed explanation goes here

if(omega<0)
    error("Omega has to be positive in order to calculate the force and the torque");
end

[fL, fD] = findCoefficient([-45, -40, -30, -20, -10, 0, 10, 20, 30, 40, 45], [-0.46, -0.48, -0.46, -0.38, -0.2, 0, 0.2, 0.38, 0.46, 0.48, 0.46], [0.78, 0.68, 0.48, 0.22, 0.08, 0.02, 0.08, 0.22, 0.48, 0.68, 0.78]);

T0 = calculateT0(1.47*10^5, 1.65*10^5, omega, -132, 132);

FxB = [T0*polyval(fD, delta) 0 0];
FyB = [0 T0*polyval(fL, delta)/2 0];
TauzB = cross([41.5 0 0], FxB+FyB); % 41.5 is caused by the reference system change; 7.1 m has not been considered since the propellers are symmetrical

F = [FxB(1) FyB(2) TauzB(3)];
end

