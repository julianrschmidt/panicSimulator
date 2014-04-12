function [ validatedBool ] = validateExitCoord( exitCoord )
%VALIDATEEXITCOORD Summary of this function goes here
%   Detailed explanation goes here
if validateNum(exitCoord, 'double', [-inf,inf], [1, 1], [4,4])
    validatedBool = true;
    return
end
validatedBool = false;

end

