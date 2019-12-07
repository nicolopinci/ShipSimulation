function [] = visualizeInterpolation(rudderArray, low, high, medium, fig_num, name)
%visualizeInterpolation This function allows to show the result of the
%interpolation of the coefficients fD and fL.
%   This function is part of the visualization (or presentation) part.

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

