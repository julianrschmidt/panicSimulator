%rhs.m: function file for use with ode45 
%rhs.m: returns right hand side of 1st order ODE "d(rv)/dt = f(t,rv)"

function out = rhs2Col(~,odeVec,radii,walls,wallLines,settings, hObject) % input: time vector dt and initial state vector odeVec
% initial state vector 'odeVec' is a row vector:
% x(agent1),...,x(agentN),y(agent1),...,y(agentN),vx(agent1),...,vx(agentN),vy(agent1),...,vy(agentN)

handles = guidata(hObject);

NAgent = size(odeVec,1) / 4;
agents = [reshape(odeVec,NAgent,4),radii];
radialForceVec = zeros(NAgent,1);
%[agentGrid, agentCellList] = generateGrid(agents,settings); %update agentGrid
%forceMatrix = zeros(NAgent, 2);


xDes1 = settings.xDes1; %get 'xDes1'
yDes1 = settings.yDes1; %get 'yDes1'
vDes  = settings.vDes;  %get 'vDes'
density  = settings.density;  %get 'mass'
xMax  = settings.xMax;  %get 'xMax'
mass = density.*pi.*radii.^2;
%yMax  = settings.yMax;  %get 'yMax'
%dt    = settings.dt;    %get 'dt'

%---accelI force-----------------------------------------------------------
tau = settings.tau; %time in units [s]

xDesVec = xDes1*ones(NAgent,1) - agents(:,1);
yDesVec = yDes1*ones(NAgent,1) - agents(:,2);
xDesVec(xDesVec<=0) = xMax; % if x coordinate of agent > xDes1 the agent wants to go to xMax
dist2exitVec = sqrt(xDesVec.^2 + yDesVec.^2); %calculate distance to exit vector

ex = xDesVec ./ dist2exitVec; %unitary vector of the desired direction (x-component)
ey = yDesVec ./ dist2exitVec; %unitary vector of the desired direction (y-component)

agentForceVecX = mass./tau .* (vDes*ex - agents(:,3)).* (rand(NAgent, 1)*0.2+0.9); %acceleration in x-direction
agentForceVecY = mass./tau .* (vDes*ey - agents(:,4)).* (rand(NAgent, 1)*0.2+0.9); %acceleration in x-direction

%---forceIJ----------------------------------------------------------------
A = settings.A; %force in [Newton]
B = settings.B; %distance in [meter]
k = settings.k; %body constant in units [kg*s^(-2)]
kappa = settings.kappa; %sliding friction constant in units [kg*m^(-1)*s^(-1)]

[mesh1radi, mesh2radi] = meshgrid(agents(:,5),agents(:,5));
rij = mesh1radi + mesh2radi; %radius of agent i + radius of agent j Matrix

[mesh1X, mesh2X] = meshgrid(agents(:,1),agents(:,1));
[mesh1Y, mesh2Y] = meshgrid(agents(:,2),agents(:,2));
distanceMatrixX = mesh2X-mesh1X; % distance matrix in x direction
distanceMatrixY = mesh2Y-mesh1Y; % distance matirx in y direction
dij = sqrt(distanceMatrixX.^2+distanceMatrixY.^2) + diag(100*ones(NAgent, 1)); %center of mass distance between agents i&j Matrtix

nxij = distanceMatrixX ./ dij; %normalized vector pointing from agent i to agent j (x-component) Matrix
nyij = distanceMatrixY ./ dij; %normalized vector pointing from agent i to agent j (y-component) Matrix

deltaij = rij - dij; %Matrix if agent i % j do touch or not

repulsive = A*exp(deltaij/B); %repulsive interaction force Matrix

forceMatrixX = repulsive.*nxij; %add forceIJ to forceMatrix
forceMatrixY = repulsive.*nyij; %add forceIJ to forceMatrix

touching = sparse(deltaij > 0);
if any(touching(:))
    [mesh1vX, mesh2vX] = meshgrid(agents(:,3),agents(:,3));
    [mesh1vY, mesh2vY] = meshgrid(agents(:,4),agents(:,4));
    velocityMatrixX = mesh1vX-mesh2vX; % velocity difference matrix in x direction
    velocityMatrixY = mesh1vY-mesh2vY; % velocity difference matrix in y direction
    
    body = k*deltaij.*touching;    
    
    bodyX = body.*nxij;
    bodyY = body.*nyij;
    
    radialForceMatrix = body;

    sliding = kappa*deltaij.*touching.*(-velocityMatrixX.*nyij + velocityMatrixY.*nxij);

    slidingX = -sliding.*nyij;
    slidingY = sliding.*nxij;

    forceMatrixX = forceMatrixX + bodyX + slidingX;
    forceMatrixY = forceMatrixY + bodyY + slidingY;
    
    radialForceVec = sum(radialForceMatrix, 2);
end

agentForceVecX = agentForceVecX + sum(forceMatrixX, 2);
agentForceVecY = agentForceVecY + sum(forceMatrixY, 2);
%---forceIW----------------------------------------------------------------
if size(walls, 1) > 0
    [mesh1radi, mesh2radi] = meshgrid(walls(:,3),agents(:,5));
    rij = mesh1radi + mesh2radi; %radius of agent i + radius of agent j Matrix

    [mesh1X, mesh2X] = meshgrid(walls(:,1),agents(:,1));
    [mesh1Y, mesh2Y] = meshgrid(walls(:,2),agents(:,2));
    distanceMatrixX = mesh2X-mesh1X; % distance matrix in x direction
    distanceMatrixY = mesh2Y-mesh1Y; % distance matirx in y direction
    dij = sqrt(distanceMatrixX.^2+distanceMatrixY.^2); %center of mass distance between agents i&j Matrtix

    nxij = distanceMatrixX ./ dij; %normalized vector pointing from wall j to agent i(x-component) Matrix
    nyij = distanceMatrixY ./ dij; %normalized vector pointing from wall j to agent i(y-component) Matrix

    deltaij = rij - dij; %Matrix if agent i % j do touch or not

    repulsive = A*exp(deltaij/B); %repulsive interaction force Matrix

    forceMatrixX = repulsive.*nxij;
    forceMatrixY = repulsive.*nyij;

    touching = sparse(deltaij > 0);
    if any(touching(:))
        body = k*deltaij.*touching;

        bodyX = body.*nxij;
        bodyY = body.*nyij;

        radialForceMatrix = body;

        meshvx = repmat(agents(:,3), 1, size(walls, 1));
        meshvy = repmat(agents(:,4), 1, size(walls, 1));

        sliding = -kappa*deltaij.*touching.*(-meshvx.*nyij + meshvy.*nxij);

        slidingX = -sliding.*nyij;
        slidingY = sliding.*nxij;

        forceMatrixX = forceMatrixX + bodyX + slidingX;
        forceMatrixY = forceMatrixY + bodyY + slidingY;

        radialForceVec = radialForceVec + sum(radialForceMatrix,2);
    end

    agentForceVecX = agentForceVecX + sum(forceMatrixX,2);
    agentForceVecY = agentForceVecY + sum(forceMatrixY,2);
end

%--force with wall lines

NWallLines = size(wallLines, 1);

if NWallLines > 0

    x1w = wallLines(:,1);
    y1w = wallLines(:,2);
    x2w = wallLines(:,3);
    y2w = wallLines(:,4);

    nx = -y2w + y1w;
    ny = x2w - x1w;
    nLength = sqrt(nx.^2 + ny.^2);
    nx = nx./nLength;
    ny = ny./nLength;

    meshx1 = repmat(x1w', NAgent, 1);
    meshy1 = repmat(y1w', NAgent, 1);

    meshNx = repmat(nx', NAgent, 1);
    meshNy = repmat(ny', NAgent, 1);

    meshX = repmat(agents(:,1), 1, NWallLines);
    meshY = repmat(agents(:,2), 1, NWallLines);

    temp = (meshX - meshx1).*meshNx + (meshY - meshy1).*meshNy;
    lotX = meshX - temp.*meshNx;
    lotY = meshY - temp.*meshNy;

    sortMatrixBool = x1w < x2w;

    minXw = x1w.*sortMatrixBool + x2w.*(~sortMatrixBool);
    maxXw = x1w.*(~sortMatrixBool) + x2w.*(sortMatrixBool);

    sortMatrixBool = y1w < y2w;

    minYw = y1w.*sortMatrixBool + y2w.*(~sortMatrixBool);
    maxYw = y1w.*(~sortMatrixBool) + y2w.*(sortMatrixBool);

    meshMinXw = repmat(minXw', NAgent, 1);
    meshMaxXw = repmat(maxXw', NAgent, 1);
    meshMinYw = repmat(minYw', NAgent, 1);
    meshMaxYw = repmat(maxYw', NAgent, 1);

    shortestX = min(max(lotX, meshMinXw), meshMaxXw);
    shortestY = min(max(lotY, meshMinYw), meshMaxYw);

    distanceMatrixX = meshX-shortestX; % distance matrix in x direction
    distanceMatrixY = meshY-shortestY; % distance matirx in y direction
    dij = sqrt(distanceMatrixX.^2+distanceMatrixY.^2); %center of mass distance between agents i&j Matrtix

    nxij = distanceMatrixX ./ dij; %normalized vector pointing from wall j to agent i(x-component) Matrix
    nyij = distanceMatrixY ./ dij; %normalized vector pointing from wall j to agent i(y-component) Matrix

    deltaij = repmat(radii, 1, NWallLines) - dij; %Matrix if agent i % j do touch or not

    repulsive = A*exp(deltaij/B); %repulsive interaction force Matrix

    forceMatrixX = repulsive.*nxij;
    forceMatrixY = repulsive.*nyij;

    touching = sparse(deltaij > 0);
    if any(touching(:))
        body = k*deltaij.*touching;
        
        radialForceMatrix = body;

        bodyX = body.*nxij;
        bodyY = body.*nyij;

        meshvx = repmat(agents(:,3), 1, NWallLines);
        meshvy = repmat(agents(:,4), 1, NWallLines);

        sliding = -kappa*deltaij.*touching.*(-meshvx.*nyij + meshvy.*nxij);

        slidingX = -sliding.*nyij;
        slidingY = sliding.*nxij;

        forceMatrixX = forceMatrixX + bodyX + slidingX;
        forceMatrixY = forceMatrixY + bodyY + slidingY;

        radialForceVec = radialForceVec + sum(radialForceMatrix,2);
    end

agentForceVecX = agentForceVecX + sum(forceMatrixX,2);
agentForceVecY = agentForceVecY + sum(forceMatrixY,2);

end

out = [odeVec(2*NAgent+1:4*NAgent);agentForceVecX./mass;agentForceVecY./mass]; % "dx/dt = v1", "dy/dt = v2"
handles.simulationObj.pressure = radialForceVec./(2*pi*radii);
guidata(hObject, handles);
end



