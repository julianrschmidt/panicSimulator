function [ validatedBool ] = validateExitCoord( exitCoord )
%VALIDATEEXITCOORD validates if exitCoord is of right format

if validateNum(exitCoord, 'double', [-inf,inf], [1, 1], [4,4])
    validatedBool = true;
    return
end
validatedBool = false;

end

