function [ checkBool ] = checkWalls( walls )
%CHECKWALLS Summary of this function goes here
%   Detailed explanation goes here
if testNum(walls, 'double', [-inf,inf], [0, inf], [3,3])
    checkBool = true;
    return
end
checkBool = false;

end

