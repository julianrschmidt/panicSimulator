function [ left ] = isLeft( a, b, c )
%ISLEFT Summary of this function goes here
%   Detailed explanation goes here
    left =  ((b(:,1) - a(:,1)).*(c(:,2) - a(:,2)) - (b(:,2) - a(:,2)).*(c(:,1) - a(:,1))) > 0;
end

