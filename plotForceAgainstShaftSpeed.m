function plotForceAgainstShaftSpeed(minShaftSpeed,maxShaftSpeed,shaftStep, kp, kn, fig_num)
%plotForceAgainstShaftSpeed This function calculates and plots the force T0
%with respect to the value of omega
%   This function calculates and plots the force T0
%with respect to the value of omega for all the possible values of omega.
%In particular, the initial omega (minShaftSpeed) and the final omega
%(maxShaftSpeed) have to be specified. Moreover, shaftStep considers the
%distance between a function evaluation and the next one. kp and kn are
%defined according to their meaning in calculateT0.

omega = minShaftSpeed:shaftStep:maxShaftSpeed;
T0 = zeros(1, length(omega));

for i = 1:length(omega)
    T0(i) = calculateT0(kp, kn, rpmToHz(omega(i)), minShaftSpeed, maxShaftSpeed);
end

figure(fig_num);
plot(omega,T0)
title('Force with respect to shaft speed')
xlabel('Shaft speed \omega [Hz]')
ylabel('Force T_0 [N]')
grid on

end

