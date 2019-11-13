function R = calculateR(phi)
%calculateR calculate the rotation matrix on the basis of the heading
%   The rotation matrix is defined as R = [cos(phi) -sin(phi) 0; sin(phi)
%   cos(phi) 0; 0 0 1], where phi is the heading.
R = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1];

end

