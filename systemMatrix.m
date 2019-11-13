function [A,B] = systemMatrix(R,invM,D,F)
%systemMatrix This function calculate the ship system matrices A and B
%   A is defined as [zeros(3) R; zeros(3) invM*D*(-1)] and B is defined as
%   the following column vector: [0 0 0 invM*F]'

A = [zeros(3) R; zeros(3) invM*D*(-1)];
referenceVariation = [0 0 0];
B = vertcat(referenceVariation', invM*F);

end

