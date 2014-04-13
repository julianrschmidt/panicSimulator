function [ simulationObj ] = agentsStep( simulationObj, settings, hObject)
%AGENTSSTEP calculates the new agent matrix after one time step with ode23
%   and the right hand side of the ODE of this model defined by odeRhs or
%   odeRhsWithPressure if pressure calculations are included
% see also: ODE23


agents = simulationObj.agents;
t = simulationObj.tSimulation;
columns = simulationObj.columns;
wallLines = simulationObj.wallLines;
exitCoord = simulationObj.exitCoord;
dt = settings.dtPlot; %get 'dt'
pressureBool = settings.pressureBool;

NAgent = size(agents, 1); %get number of agents

%%---ode23 integration-----------------------------------------------------

odeVec = reshape(agents(:,1:4),4*NAgent,1); %create 'odeVec' initial state column vector (with radius)
radii = agents(:,5);
odeOptions = odeset('AbsTol',1e-2,'RelTol',1e-2, 'Events',@(t,y) odeEventFunction(t,y,exitCoord)); % RelTol: measure of error relative to size of each solution component. Default is 1e-3
if pressureBool
    [tVec, odeAgents, TE, ~, IE] = ode23(@(t,y)odeRhsWithPressure(t,y,radii,columns,wallLines,exitCoord,settings, hObject),[t,t+dt],odeVec,odeOptions); %solve ODE with 'ode23'
    handles = guidata(hObject);
    simulationObj.pressure = handles.simulationObj.pressure;        
else
    [tVec, odeAgents, TE, ~, IE] = ode23(@(t,y)odeRhs(t,y,radii,columns,wallLines,exitCoord,settings),[t,t+dt],odeVec,odeOptions); %solve ODE with 'ode23'
end
agents(:,1:4) = reshape(odeAgents(end,:),NAgent,4); %uptate 'agents' matrix
timesAgentsThroughDoor = TE(IE <= NAgent);
allThroughDoor = any(IE == NAgent + 1);
simulationObj.tSimulation = tVec(end);
simulationObj.agents = agents;
simulationObj.allThroughDoor = allThroughDoor;
simulationObj.timesAgentsThroughDoor = [simulationObj.timesAgentsThroughDoor; timesAgentsThroughDoor];

%toc
end

