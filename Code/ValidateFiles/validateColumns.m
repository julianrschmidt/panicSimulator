function [ validatedBool ] = validateColumns( columns )
%VALIDATECOLUMNS Summary of this function goes here
%   Detailed explanation goes here
if validateNum(columns, 'double', [-inf,inf], [0, inf], [3,3])
    validatedBool = true;
    return
end
validatedBool = false;

end

