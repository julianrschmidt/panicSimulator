function [ agents ] = createAgents( settings ) 
%CREATEAGENTS generates agent matrix randomly in the arena, in dependence
% of arena size, wall angle and door width all defined in settings 
% structure, if not all agents fit in the desired space after some time of 
% trial, an error message is shown, asking whether to try again with more 
% time, or leave as is
%
% vMean, vVar - absolute velocity of one agent is gamma distributed with
%               mean value vMean and variance vVar. The angle of direction
%               is uniformly distributed in [0, 360]
% NAgent - is the number of agents created

%copy settings to local variables
NAgent = settings.NAgent;
border = settings.border;
wallAngle = settings.wallAngle/180*pi;
doorWidth = settings.doorWidth;
xMax = settings.xMax;
yMax = settings.yMax;
vMean = settings.vMeanAgentsIni;
vVar = settings.vVarAgentsIni;


%radius of agents
rVec = createAgentRadii(NAgent);
rMax = max(rVec);

%velocity of agents
gammaK = vMean^2/vVar;
gammaTheta = vVar/vMean;
vAbs = gamrnd(gammaK, gammaTheta, NAgent, 1);
vAngles = 2*pi*rand(NAgent, 1);

vxAgents = vAbs.*cos(vAngles);
vyAgents = vAbs.*sin(vAngles);

% build agents matrix
agents = [zeros(NAgent,1), zeros(NAgent,1), vxAgents, vyAgents, rVec];

%random placement
Xcrit = xMax - border - ((yMax-doorWidth)/2 - border)*tan(wallAngle); % Xcrit is the critical x-value differeitiate between near door coordinates and bulk
agentNr = 1; % initialize
numberOfTries = 0;
while agentNr < NAgent + 1
    xAgents = (xMax-2*border)*rand(1) + border - rMax; %choose random x-coordinate
    
    if xAgents < Xcrit
        yAgents = rand(1)*(yMax-2*(border+rMax))+border+rMax; %choose random y-coordinate
    else
        yRange = 2*(xMax-border-xAgents)/tan(wallAngle) + doorWidth - 2*(rMax); % range of possible y-values
        yAgents = yMax/2 + rand(1)*yRange-yRange/2; %choose random y-coordinate
    end
    agents(agentNr,1:2) = [xAgents,yAgents]; %update agents matrix
    
    newAgent = true; % initialize newAgent condidion
    for j = 1:agentNr - 1
        if norm(agents(j,1:2)-agents(agentNr,1:2)) < agents(j,5) + agents(agentNr,5) % new agent collides with an other one
            newAgent = false;             
        end
    end
    
    if newAgent
       agentNr = agentNr + 1;     
    end
    numberOfTries = numberOfTries + 1;
    if numberOfTries > 100 * NAgent
        [answerString] = agentPlacingTimeoutGui();
        if strcmp(answerString, 'No')
            agents = [];
            break;            
        else
            numberOfTries = 0;
        end    
    end
end

end

