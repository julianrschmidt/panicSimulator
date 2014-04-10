function [ num, sucess ] = testStr( str, style, range )
%TESTSTR Summary of this function goes here
%   Detailed explanation goes here
num = str2double(str);
if isnan(num)
    num = [];
    sucess = false;
    return;
elseif ~isreal(num)
    num = [];
    sucess = false;
    return;
elseif isinf(num)
    num = [];
    sucess = false;
    return;
elseif num < range(1) || num > range(2)
            num = [];
            sucess = false;
            return;  
elseif strcmp(style, 'double') 
    sucess = true;
    return;
elseif strcmp(style, 'int')
    if rem(num, 1) ~= 0
        num = [];
        sucess = false;
        return;
    else
        sucess = true;
        return;
    end    
end


end

