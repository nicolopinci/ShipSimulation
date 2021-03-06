function [F, Fl, Fh] = get_force_torque(omega,delta)
%get_force_torque This function gives the force and the torque as a result.
%   The first variable being returned corresponds to the force and the
%   torque in case the values of the drag and lift array are considered
%   without any uncertainty. Fl and Fh refer, respectively, to the
%   situations in which the uncertainty is taken into account with the
%   negative sign and with the positive sign.

[rudderArray, liftArray, dragArray, accuracy] = getCoefficientData(); % gets the arrays from the input data

% Calculates the coefficients fL and fD for the different uncertainties
[fL, fD] = findCoefficient(rudderArray, liftArray, dragArray, 0);
[fLl, fDl] = findCoefficient(rudderArray, liftArray, dragArray, -accuracy/2);
[fLh, fDh] = findCoefficient(rudderArray, liftArray, dragArray, accuracy/2);

% Calls the optimized version to calculate the forces and the torques
F = get_force_torque_OPT(omega,delta, fL, fD);
Fl = get_force_torque_OPT(omega,delta, fLl, fDl);
Fh = get_force_torque_OPT(omega,delta, fLh, fDh);

end

