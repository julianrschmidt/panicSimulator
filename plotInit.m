function plotObj = plotInit(simulationObj, settings, hFigure)
%PLOTINIT plots agents, walls and the grid
% returns the handle array to the plotted cells, agents and walls
walls = simulationObj.walls;
wallLines = simulationObj.wallLines;
exitCoord = simulationObj.exitCoord;
agents = simulationObj.agents;
figure(hFigure);
% hold on;
% axis off;
% plot the grid
hCells = plotGrid([0, settings.xMax, 0, settings.yMax]);
% plot agents and walls
[hAgents, hWalls, hWallLines, hExit] = plotAgents(agents, walls, wallLines, exitCoord, settings.xMax, settings.yMax);
daspect([1,1,1]);
% hold off;

plotObj.hAgents = hAgents;
plotObj.hCells = hCells;
plotObj.hWalls = hWalls;
plotObj.hWallLines = hWallLines;
plotObj.hExit = hExit;

end

