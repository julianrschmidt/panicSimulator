function [ settings ] = createDefaultSettings(  )
%CREATEDEFAULTSETTINGS this function can be called to produce a default 
% settings structure
settings.A = 2000; %force in [Newton]
settings.B = 0.08; %distance in [meter]
settings.k = 1.2e5; %body constant in units [kg*s^(-2)]
settings.kappa = 2.4e5; %sliding friction constant in units [kg*m^(-1)*s^(-1)]
settings.tau = 0.5;

settings.pressureBool = true;
settings.wallAngle = 0; % wall Angle = 0 corresponds to normal wall

settings.NAgent = 50; % number of agents created if they are randomly created
settings.border = 2; % border in grid
settings.yMax = 20; %[m] length of arena in y direction
settings.doorWidth = 1; %[m]    % width of door, only relevant if standard 
                                % columns are created


% agent settings
settings.density = 350; %[kg]/m^2 density of an agent, 
                    % corresponds to 67kg for small agent(r=0.235m)
                    % and 96 kg for big agent (r=0.28)
settings.vMeanAgentsIni = 0.5; %[m/s] mean velocity at initialization
settings.vVarAgentsIni = 0.1; %[m/s] variance of velocity at initalization

% xMax setting
settings.xMaxCalcBool = true;
settings.xMax = calcXMax(settings); %[m] length of arena in x direction

settings.vDes = 1;              % desired velocity of an agent

% established are 'randomLeftHalf' and 'random' (28.11.)
settings.agentPositionStyle = 'randomLeftHalf';
settings.agentPositionFilename = ''; % full filename to file containing at
                                    % least the variable agents

% established are 'standard' and 'random' (28.11.)
settings.wallPositionStyle = 'standard';
settings.wallPositionFilename = '';% full filename to file containing at
                                    % least the variable columns


settings.dt = 0.01; %[s] simulated time step
settings.dtPlot = 0.5; %[s] frame shown in these time steps
settings.realTimeBool = false;

end

