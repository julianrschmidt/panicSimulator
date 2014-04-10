function [ WallPoints ] = generateWallLine2( Xstart, Ystart, Xend, Yend, radiusMax )
%GENERATEWALLLINE returns coordinates of the center of equally distant 
% points on a line or lines from exact [Xstart, Ystart] to approximately [Xend, Yend].
% Each point has the fixed radius of 'radiusMax'. 
% A minimum nummber of points is created. 
% The first point is exact and do not extend the line.
WallPoints = [];

for j=1:1:length(Xstart)
	
    d = sqrt((Xend(j)-Xstart(j))^2+(Yend(j)-Ystart(j))^2); %distance between Start and End
    r = radiusMax; %radius of Wall points
    N = ceil(d / (2*r)); %number of Wall Points
    
    
    Xend = (N*2*r/d)*(Xend-Xstart) + Xstart; %new (approximated) Xend coordinate
    Yend = (N*2*r/d)*(Yend-Ystart) + Ystart; %new (approximated) Yend coordinate
    
    dx = (Xend(j) - Xstart(j)) / N; %distance of Wall Points in X-direction
    dy = (Yend(j) - Ystart(j)) / N; %distance of Wall Points in X-direction
    
    xCoord = linspace(Xstart(j)+dx/2,Xend(j)-dx/2,N)';
    yCoord = linspace(Ystart(j)+dy/2,Yend(j)-dy/2,N)';
    rVec = r*ones(N, 1);
    
    WallPoints = [WallPoints; ...
        xCoord,...
        yCoord, ...
        rVec];
    
end
end

