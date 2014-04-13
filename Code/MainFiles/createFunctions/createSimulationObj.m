function simulationObj = createSimulationObj( settings, simulationObj)
%CREATESIMULATIONOBJ generates agent matrix and wall matrix and exit line
%   dependent on settings
%   agents: [x, y, vx, vy, radius]
%   columns: [x, y, radius]
%   wall lines: [x1, y1, x2, y2]

% copying the settings variables to local variables
xMax = settings.xMax;%[m]
yMax = settings.yMax; %[m]
doorWidth = settings.doorWidth; %[m]
border = settings.border;
wallAngle = settings.wallAngle/180*pi;


                    
%% generate Agents
if strcmp(settings.agentPositionStyle, 'randomLeftHalf')
    agents = createAgents(settings); 
elseif strcmp(settings.agentPositionStyle,'filename')
    if exist(settings.agentPositionFilename, 'file') == 2
        if sum(strcmp(who('-file', settings.agentPositionFilename), 'agents')) == 1
            load(settings.agentPositionFilename, 'agents');
            if validateAgents(agents)
            else
                agents = [];
                errorOpenFileGui('filename',settings.agentPositionFilename);
            end
        else
            agents = [];
            errorOpenFileGui('filename',settings.agentPositionFilename);
        end
    else
        agents = [];
        errorOpenFileGui('filename',settings.agentPositionFilename);
    end            
else
    agents = [];
end
    
%% generate Walls
% generate exit
exitCoord = [xMax - border, yMax/2 - doorWidth/2, xMax - border, yMax/2 + doorWidth/2];
columns = [];
wallLines = [];

XIntersect = 0.5*(settings.yMax-settings.doorWidth)*tan(wallAngle); % wall minimum in x direction
if strcmp(settings.wallPositionStyle, 'standard')    

    if XIntersect + border < xMax
        wallLines = [xMax - border - XIntersect, 0, xMax - border, yMax/2 - doorWidth/2;...
                    xMax - border - XIntersect, yMax, xMax - border, yMax/2 + doorWidth/2];
    else
        wallLines = [xMax - border, yMax/2 - doorWidth/2, 0, yMax/2 - doorWidth/2 - (xMax-border)/tan(wallAngle);...
                    xMax - border, yMax/2 + doorWidth/2, 0, yMax/2 + doorWidth/2 + (xMax-border)/tan(wallAngle)];
    end

    columns = [];
elseif strcmp(settings.wallPositionStyle, 'filename')
    if exist(settings.wallPositionFilename, 'file') == 2
        if sum(strcmp(who('-file', settings.wallPositionFilename), 'columns')) == 1 &&...
                sum(strcmp(who('-file', settings.wallPositionFilename), 'wallLines')) == 1 &&...
                sum(strcmp(who('-file', settings.wallPositionFilename), 'exitCoord')) == 1
            load(settings.wallPositionFilename, 'columns', 'wallLines', 'exitCoord');
            if validateColumns(columns) && validateWallLines(wallLines) &&validateExitCoord(exitCoord)
            else
                errorOpenFileGui('filename',settings.wallPositionFilename);
            end
        else
            errorOpenFileGui('filename',settings.wallPositionFilename);
        end
    else
        errorOpenFileGui('filename',settings.wallPositionFilename);
    end            
end


%% save all in simulationObj
simulationObj.agents = agents;
simulationObj.columns = columns;
simulationObj.exitCoord = exitCoord;
simulationObj.wallLines = wallLines;
end

