function [ simulationObj ] = resetSimulationObj( simulationObj )
%RESETSIMULATIONOBJ Resets variables of simulation obj, like time...
simulationObj.tSimulation = 0;
simulationObj.tPlot = 0;
simulationObj.timesAgentsThroughDoor = [];
simulationObj.allThroughDoor = false;
simulationObj.pressure = zeros(1,size(simulationObj.agents, 1));

end

