function [fL, fD] = findCoefficient(rudderArray,liftArray, dragArray, err)
%findCoefficient This function is used in order to find a coefficient (fL
%or fD).
%   The coefficient is calculated on the basis of a given dataset,
%   consisting in a rudder angle array rudderArray and in a force array
%   forceArray. liftArray and dragArray contains the values of the considered
%   forces divided by T0, that is the force in the x direction.

% fL = L/T0
% fD = 1-D/T0



if not(and(length(liftArray) == length(dragArray), length(dragArray) == length(rudderArray)))
    error("Please use arrays with the same size");
end

realDrag = [];

for j=1:length(rudderArray)
    dragArray(j) = dragArray(j)+err;
    liftArray(j) = liftArray(j)+err;
end

realLift = liftArray;


for i=1:length(rudderArray)
    realDrag(i) = 1-dragArray(i);
end

fL = polyfit(rudderArray, realLift, 3); % interpolation with a grade 3 polynomial function
fD = polyfit(rudderArray, realDrag, 3); % interpolation with a grade 3 polynomial function

end

