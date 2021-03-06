function F = get_force_torque_OPT(omega,delta, fL, fD)
%get_force_torque_OPT This (optimized) function gives the force and the torque as a result.
%   Differently from the non-optimized version, forces and torques are
%   calculated on the basis of the given fL and fD. There is no need to
%   output the low, average and high forces and torques, that correspond to
%   different uncertainties, since it is possible to call this function
%   using different fL and fD to obtain them.

[kp, kn] = getKpKn();
[minShaftSpeed, maxShaftSpeed] = getShaftSpeedLimits();
distance = getDistanceCenterOfMass();

T0 = calculateT0(kp, kn, omega, minShaftSpeed, maxShaftSpeed);

if(omega<0) % The shaft has a negative rotation, therefore it is not possible to calculate the drag and the lift because of how the problam has been specified
    Fx = [T0 0 0];
    Fy = [0 0 0];
else

    Fx = [2*T0*polyval(fD, delta) 0 0]; % with respect to the world
    Fy = [0 -2*T0*polyval(fL, delta) 0]; % with respect to the world
    
    FxB = Fx; % with respect to the body
    FyB = -Fy; % with respect to the body
end

TauzB = cross([distance 0 0], FyB+FxB); % the x distance is caused by the reference system change; the y distance has not been considered since the propellers are symmetrical
F = FxB + FyB + TauzB; % with respect to the body

% Note: the distance refers to the distance from the center of mass to the
% x coordinate of the point on which the lift force is applied.

end

