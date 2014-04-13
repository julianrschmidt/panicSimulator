function [ left ] = isLeft( a, b, c )
%ISLEFT returns true when [c1,c2] is left of line defined by end points 
%  [a1,a2] and [b1,b2] in direction of travel from a to b
    left =  ((b(:,1) - a(:,1)).*(c(:,2) - a(:,2)) - (b(:,2) - a(:,2)).*(c(:,1) - a(:,1))) > 0;
end

