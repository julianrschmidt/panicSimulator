function [ num, sucess ] = validateStr( str, style, range )
%VALIDATESTR validates if STR can be transformed to number and is of desired format
%   STYLE  -  'double' or 'int'
%   RANGE - desired range of values [min, max] min <= num <= max
%
%   if one of the conditions above is not validated, sucess will be false
%   otherwise it will be true
% see also: VALIDATENUM
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

