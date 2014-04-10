function [ checkBool ] = checkWallLines( wallLines )
%CHECKWALLLINES Summary of this function goes here
%   Detailed explanation goes here
if testNum(wallLines, 'double', [-inf,inf], [0, inf], [4,4])
    checkBool = true;
    return
end
checkBool = false;

end

