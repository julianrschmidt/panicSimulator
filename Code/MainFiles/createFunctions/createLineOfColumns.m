function [ WallPoints ] = createLineOfColumns( Xstart, Ystart, Xend, Yend, radiusMax )
%CREATELINEOFCOLUMNS returns coordinates of the center of equally distant 
% points on a line or lines from [Xstart, Ystart] to [Xend, Yend].
% Each column has a maximum radius of radiusMax. 
% A minimum nummber of columns is created. 
% The first and last do not extend the line.
WallPoints = [];

for j=1:1:length(Xstart)
	
    d = sqrt((Xend(j)-Xstart(j))^2+(Yend(j)-Ystart(j))^2); %distance between Start and End
    N = ceil(d / (2*radiusMax)); %number of Wall Points
    r = (d / N) / 2;%radius of Wall points
    
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

