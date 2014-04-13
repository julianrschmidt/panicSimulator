function [ validatedBool ] = validateWallLines( wallLines )
%VALIDATEWALLLINES validates if wallLines is of right format

if validateNum(wallLines, 'double', [-inf,inf], [0, inf], [4,4])
    validatedBool = true;
    return
end
validatedBool = false;

end

