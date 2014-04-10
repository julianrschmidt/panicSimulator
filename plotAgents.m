function [hAgents, hWalls, hWallLines, hExit] = plotAgents( agents, walls, wallLines, exitCoord, xMax, yMax )
%PLOTAGENTS plots all agents and walls in the range [xMax, yMax]
% returns the handle to all agent circles (hagents) and all wall
% circles (hWalls)
% the agent and wall ids are also stored in the 'UserData' of each circle
% object
xlim([0, xMax]);
ylim([0, yMax]);
NAgents = size(agents, 1);
NWalls = size(walls, 1);
NWallLines = size(wallLines, 1);

hAgents = zeros(1,NAgents);

for j = 1:NAgents    
    hAgents(j) = plotAgentCircle(agents(j,1), agents(j,2), agents(j,5));
    set(hAgents(j), 'UserData', [1,j]);
end

hWalls = zeros(1,NWalls);
for j = 1:NWalls    
    hWalls(j) = plotWallCircle(walls(j,1), walls(j,2), walls(j,3));
    set(hWalls(j), 'UserData', [2,j]);
end

hWallLines = zeros(1, NWallLines);
for j = 1:NWallLines
    hWallLines(j) = plotWallLine([wallLines(j,1), wallLines(j,3)], [wallLines(j,2), wallLines(j,4)]);
    set(hWallLines(j), 'UserData', [3,j]);
end

hExit = plotExitLine([exitCoord(1), exitCoord(3)], [exitCoord(2), exitCoord(4)]);
set(hExit(1), 'UserData', [4, hExit(2)]);
set(hExit(2), 'UserData', [4, hExit(1)]);


end

