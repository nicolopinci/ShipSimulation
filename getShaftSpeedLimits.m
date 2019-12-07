function [minShaft,maxShaft] = getShaftSpeedLimits()
%getShaftSpeedLimits This function outputs the maximum speed of the
%shaft, expressed in RPM.
%   The provided values depend on the given model and they can change in
%   case the shaft changes.
minShaft = -132;
maxShaft = 132;
end

