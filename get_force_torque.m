function [F, Fl, Fh] = get_force_torque(omega,delta)
%get_force_torque Summary of this function goes here
%   Detailed explanation goes here

[rudderArray, liftArray, dragArray, accuracy] = getCoefficientData();

[fL, fD] = findCoefficient(rudderArray, liftArray, dragArray, 0);
[fLl, fDl] = findCoefficient(rudderArray, liftArray, dragArray, -accuracy/2);
[fLh, fDh] = findCoefficient(rudderArray, liftArray, dragArray, accuracy/2);

F = get_force_torque_OPT(omega,delta, fL, fD);
Fl = get_force_torque_OPT(omega,delta, fLl, fDl);
Fh = get_force_torque_OPT(omega,delta, fLh, fDh);

end

