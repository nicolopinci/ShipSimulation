function [] = showErrorsMessage(absolute,relative, measureType)
%showErrorsMessage This function allows to visualize the absolute and
%relative errors by using a message box.
%   This function is part of the visualization (or presentation) part.

message = strcat('The absolute error for the heading is ', {' '}, num2str(absolute), {' '}, 'rad, while the relative error is ', {' '}, num2str(relative),{' '}, '%');
msgbox(message, strcat('Absolute and relative error ', {' '}, '(', measureType, ')'));

end

