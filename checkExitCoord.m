function [ checkBool ] = checkExitCoord( exitCoord )
%CHECKEXITCOORD Summary of this function goes here
%   Detailed explanation goes here
if testNum(exitCoord, 'double', [-inf,inf], [1, 1], [4,4])
    checkBool = true;
    return
end
checkBool = false;

end

