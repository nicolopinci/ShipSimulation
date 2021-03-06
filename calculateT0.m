function T0 = calculateT0(kp,kn,omega, minShaftSpeed, maxShaftSpeed)
%   calculateT0 - This function computes the force T0
%   T0 force is the force generated by the thrusters (propellers) when they
%   rotate. It can be either positive (omega >= 0) or negative (omega < 0).
%   The shaft speed is expressed in RPM (1 RPM = 1/60 Hz). kp and kn are
%   coefficients. (Suggested value for kp = 1.47 * 10^5 Ns^2, suggested value
%   for kn = 1.65 * 10^5 Ns^2, suggested values for minShaftSpeed and
%   maxShaftSpeed: -132 and 132). omega should be expressed in Hz.

if or(omega < rpmToHz(minShaftSpeed), omega > rpmToHz(maxShaftSpeed))
    error("Please define a valid omega.");
end

if (omega >= 0)
    T0 = kp*omega^2;
elseif (omega < 0)
    T0 = kn*abs(omega)*omega;
else
    error("Error in calculating T0");
end
end

