function [ simulationObj ] = updateAgents( simulationObj, settings, hObject)
%UPDATEAGENTS calculates the new agent matrix after one agent
% details needed!!!

%tic

agents = simulationObj.agents;
t = simulationObj.tSimulation;
walls = simulationObj.walls;
wallLines = simulationObj.wallLines;
exitCoord = simulationObj.exitCoord;
dt = settings.dtPlot; %get 'dt'
pressureBool = settings.pressureBool;

NAgent = size(agents, 1); %get number of agents
%%---simple integration----------------------------------------------------
% if NAgent ~= 0
%     agents(:,1) = agents(:,1) + agents(:,3)*dt;
%     agents(:,2) = agents(:,2) + agents(:,4)*dt;
% 
%     agents(:,3) = agents(:,3) + 1/mass*forceMatrix(:,1)*dt;
%     agents(:,4) = agents(:,4) + 1/mass*forceMatrix(:,2)*dt;
% end

%%---ode45 integration-----------------------------------------------------

odeVec = reshape(agents(:,1:4),4*NAgent,1); %create 'odeVec' initial state column vector (with radius)
radii = agents(:,5);
odeOptions = odeset('AbsTol',1e-2,'RelTol',1e-2, 'Events',@(t,y) event_function(t,y,exitCoord)); % RelTol: measure of error relative to size of each solution component. Default is 1e-3
if pressureBool
    [tVec, odeAgents, TE, ~, IE] = ode23(@(t,y)rhs3Col(t,y,radii,walls,wallLines,exitCoord,settings, hObject),[t,t+dt],odeVec,odeOptions); %solve ODE with 'ode23'
    handles = guidata(hObject);
    simulationObj.pressure = handles.simulationObj.pressure;        
else
    [tVec, odeAgents, TE, ~, IE] = ode23(@(t,y)rhs3(t,y,radii,walls,wallLines,exitCoord,settings),[t,t+dt],odeVec,odeOptions); %solve ODE with 'ode23'
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

