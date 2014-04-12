function [ validatedBool ] = validateWalls( walls )
%VALIDATEWALLS Summary of this function goes here
%   Detailed explanation goes here
if validateNum(walls, 'double', [-inf,inf], [0, inf], [3,3])
    validatedBool = true;
    return
end
validatedBool = false;

end

