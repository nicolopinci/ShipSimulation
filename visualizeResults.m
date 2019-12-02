function [] = visualizeResults(solutionL, solutionH, solution, solutionPIDlow, solutionPIDhigh, solutionPID, desiredAngle, timeL, timeH, time)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Plot T0
plotForceAgainstShaftSpeed(-132, 132, 0.1, 147000, 165000, 1);



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
plot(time, solutionPID(3,:));

hold on
plot(timeL, solutionPIDlow(3,:));

hold on
plot(timeH, solutionPIDhigh(3,:));

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
end
