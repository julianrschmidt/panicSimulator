function [ value,isterminal,direction ] = odeEventFunction( t, y, aims )
%ODEEVENTFUNCTION Summary of this function goes here
%   Detailed explanation goes here
NAgent = length(y)/4;
throughDoor = double(isLeft(aims(:,3:4),aims(:,1:2),[y(1:NAgent), y(NAgent+1:2*NAgent)]));
value = [1-throughDoor; sum(1-throughDoor)];

isterminal = [zeros(NAgent, 1);1];
direction = zeros(NAgent + 1, 1);

end

