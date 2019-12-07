function [rudderArray,liftArray, dragArray, accuracy] = getCoefficientData()
%getCoefficientData This function outputs the arrays that define the
%acquired data regarding the lift force and the drag force. Moreover, it
%outputs the accuracy of the measurement.
%   Note: the accuracy refers to the uncertainty around each value,
%   therefore half of the uncertainty will be positive with respect to the
%   measured value and half will be negative.
rudderArray = [-45, -40, -30, -20, -10, 0, 10, 20, 30, 40, 45];
liftArray = [-0.46, -0.48, -0.46, -0.38, -0.2, 0, 0.2, 0.38, 0.46, 0.48, 0.46];
dragArray = [0.22, 0.32, 0.52, 0.78, 0.92, 0.98, 0.92, 0.78, 0.52, 0.32, 0.22];
accuracy = 0.001;
end

