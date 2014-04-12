function [ validatedBool ] = validateWallLines( wallLines )
%VALIDATEWALLLINES Summary of this function goes here
%   Detailed explanation goes here
if validateNum(wallLines, 'double', [-inf,inf], [0, inf], [4,4])
    validatedBool = true;
    return
end
validatedBool = false;

end

