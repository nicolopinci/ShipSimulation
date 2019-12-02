function [] = showErrorsMessage(absolute,relative, measureType)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

message = strcat('The absolute error for the heading is ', {' '}, num2str(absolute), {' '}, 'rad, while the relative error is ', {' '}, num2str(relative),{' '}, '%');
msgbox(message, strcat('Absolute and relative error ', {' '}, '(', measureType, ')'));

end

