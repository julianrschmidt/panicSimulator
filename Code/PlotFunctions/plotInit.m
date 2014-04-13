function plotObj = plotInit(simulationObj, settings, hFigure)
%PLOTINIT plots agents, columns and the grid
% returns the handle array to the plotted cells, agents and columns in
% plotObj

columns = simulationObj.columns;
wallLines = simulationObj.wallLines;
exitCoord = simulationObj.exitCoord;
agents = simulationObj.agents;
figure(hFigure);

hCells = plotGrid([0, settings.xMax, 0, settings.yMax]);
% plot agents and columns
[hAgents, hColumns, hWallLines, hExit] = plotAgents(agents, columns, wallLines, exitCoord, settings.xMax, settings.yMax);
daspect([1,1,1]);

plotObj.hAgents = hAgents;
plotObj.hCells = hCells;
plotObj.hColumns = hColumns;
plotObj.hWallLines = hWallLines;
plotObj.hExit = hExit;

end

