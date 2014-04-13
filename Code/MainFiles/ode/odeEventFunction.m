function [ value,isterminal,direction ] = odeEventFunction( t, y, aims )
%ODEEVENTFUNCTION called inside ode solver, if one of value goes to 0, an
%  event is triggered and the odeSolver stores the exact time of that event
%   in this case one entry of the value array goes to 0 when an agent passes
%   the door, the ode terminates when all agents are through door
% see also: ode23
NAgent = length(y)/4;
throughDoor = double(isLeft(aims(:,3:4),aims(:,1:2),[y(1:NAgent), y(NAgent+1:2*NAgent)]));
value = [1-throughDoor; sum(1-throughDoor)];

isterminal = [zeros(NAgent, 1);1];
direction = zeros(NAgent + 1, 1);

end

