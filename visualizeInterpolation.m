function [] = visualizeInterpolation(rudderArray, low, high, medium, fig_num, name)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Interpolation
figure(fig_num);
hold on
title(strcat('Interpolation of ',{' '}, name))
xlabel('Rudder angle')
ylabel(name)
grid on

hold on
plot(rudderArray, polyval(medium, rudderArray));

grid on


hold on
plot(rudderArray, polyval(high, rudderArray));

hold on
plot(rudderArray, polyval(low, rudderArray));

legend( 'Average', 'Low', 'High')

end

