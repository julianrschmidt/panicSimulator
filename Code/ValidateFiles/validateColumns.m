function [ validatedBool ] = validateColumns( columns )
%VALIDATECOLUMNS validates if column matrix is of right format

if validateNum(columns, 'double', [-inf,inf], [0, inf], [3,3])
    validatedBool = true;
    return
end
validatedBool = false;

end

