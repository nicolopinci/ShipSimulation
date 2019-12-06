function [] = visualizeResults_OPT(rudderArray, fLl, fLh, fL, fDl, fDh, fD, solutionL, solutionH, solution, solutionPIDlow, solutionPIDhigh, solutionPID, desiredAngle, timeL, timeH, time)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Plot T0
plotForceAgainstShaftSpeed(-132, 132, 0.1, 147000, 165000, 1);


visualizeInterpolation(rudderArray, fLl, fLh, fL, 2, 'f_L');
visualizeInterpolation(rudderArray, fDl, fDh, fD, 3, 'f_D');



%Heading
figure(4)

title('Heading with respect to time')
xlabel('Time [s]')
ylabel('Heading [rad]')


hold on
plot(time, wrapTo2Pi(solution(3,:)));


hold on
plot(time, wrapTo2Pi(solutionH(3,:)));

hold on
plot(time, wrapTo2Pi(solutionL(3,:)));


grid on
hold on
plot(time, wrapTo2Pi(solutionPID(3,:)));

hold on
plot(timeL, wrapTo2Pi(solutionPIDlow(3,:)));

hold on
plot(timeH, wrapTo2Pi(solutionPIDhigh(3,:)));

hold on
fplot(desiredAngle, 'k.')


legend('Without PID (average)', 'Without PID (low)', 'Without PID (high)', 'With PID (average)','With PID (low)','With PID (high)','Objective heading')

hold off




% Trajectory
figure(5);
axis equal tight
hold on
plot(solution(2,:), solution(1,:));
title('Ship trajectory')
xlabel('y_W [m]')
ylabel('x_W [m]')
grid on

hold on
plot(solutionL(2,:), solutionL(1,:));

grid on

hold on
plot(solutionH(2,:), solutionH(1,:));

hold on
plot(solutionPID(2,:), solutionPID(1,:));

hold on
plot(solutionPIDlow(2,:), solutionPIDlow(1,:));

hold on
plot(solutionPIDhigh(2,:), solutionPIDhigh(1,:));

hold on
fplot(@(t) tan(pi/2 - desiredAngle)*t, 'k.')
legend( 'Without PID (average)', 'Without PID (low)', 'Without PID (high)', 'With PID (average)', 'With PID (low)', 'With PID (high)', 'Objective trajectory')

hold off

[abs_err, rel_err_perc] = calculateAbsoluteAndRelativeError(solutionPID(3,end), desiredAngle);
showErrorsMessage(abs_err, rel_err_perc, "average");

[abs_err_low, rel_err_perc_low] = calculateAbsoluteAndRelativeError(solutionPIDlow(3, end), desiredAngle);
showErrorsMessage(abs_err_low, rel_err_perc_low, "low");

[abs_err_high, rel_err_perc_high] = calculateAbsoluteAndRelativeError(solutionPIDhigh(3, end), desiredAngle);
showErrorsMessage(abs_err_high, rel_err_perc_high, "high");



end

