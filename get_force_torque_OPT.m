function F = get_force_torque_OPT(omega,delta, fL, fD)
%get_force_torque_OPT Summary of this function goes here
%   Detailed explanation goes here

T0 = calculateT0(1.47*10^5, 1.65*10^5, omega, -132, 132);

if(omega<0)
    Fx = [T0 0 0];
    Fy = [0 0 0];
else

    Fx = [T0*polyval(fD, delta) 0 0]; % with respect to the world
    Fy = [0 -T0*polyval(fL, delta) 0]; % with respect to the world

end

TauzB = cross([-41.5 0 0], Fx+Fy); % 41.5 is caused by the reference system change; 7.1 m has not been considered since the propellers are symmetrical
F = [Fx(1) -Fy(2) TauzB(3)]; % with respect to OB
end

