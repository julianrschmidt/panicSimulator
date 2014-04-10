function [ sucess ] = testNum( num, style, valueRange,  rowRange, columnRange)
%TESTNUM Summary of this function goes here
%   Detailed explanation goes here
if any(size(num) < [rowRange(1), columnRange(1)])...
        || any(size(num) > [rowRange(2), columnRange(2)])
    if (rowRange(1) == 0) || (columnRange(1) == 0)
        if numel(num) ~= 0
            sucess = false;
            return;
        end
    else
        sucess = false;
        return;
    end
end
if any(~isreal(num(:)))
    sucess = false;
    return;
elseif any(islogical(num(:)))
    sucess = false;
    return;
elseif any(ischar(num(:)))
    sucess = false;
    return;
elseif any(isnan(num(:)))
    sucess = false;
    return;
elseif any(isinf(num(:)))
    sucess = false;
    return;
elseif any(num(:) < valueRange(1)) || any(num(:) > valueRange(2))
            sucess = false;
            return;  
elseif strcmp(style, 'double') 
    sucess = true;
    return;
elseif strcmp(style, 'int')
    if any(rem(num(:), 1) ~= 0)
        sucess = false;
        return;
    else
        sucess = true;
        return;
    end    
end


end

