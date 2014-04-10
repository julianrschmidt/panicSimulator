function [ simulationObj ] = initSimulationObj( simulationObj )
%INITSIMULATIONOBJ Summary of this function goes here
%   Detailed explanation goes here
simulationObj.tSimulation = 0;
simulationObj.tPlot = 0;
simulationObj.timesAgentsThroughDoor = [];
simulationObj.allThroughDoor = false;
simulationObj.pressure = zeros(1,size(simulationObj.agents, 1));

end

