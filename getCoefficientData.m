function [rudderArray,liftArray, dragArray, accuracy] = getCoefficientData()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
rudderArray = [-45, -40, -30, -20, -10, 0, 10, 20, 30, 40, 45];
liftArray = [-0.46, -0.48, -0.46, -0.38, -0.2, 0, 0.2, 0.38, 0.46, 0.48, 0.46];
dragArray = [0.78, 0.68, 0.48, 0.22, 0.08, 0.02, 0.08, 0.22, 0.48, 0.68, 0.78];
accuracy = 0.001;
end

