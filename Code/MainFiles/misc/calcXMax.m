function [ xMax ] = calcXMax( settings )
%CALCXMAX calculates arena width dependent on agent number and arena
%height, such that all agents can randomly fit in the arena

rMax = 0.3;
XIntersect = 0.5*(settings.yMax-settings.doorWidth)*tan(settings.wallAngle); % wall minimum in x direction
ADoor = XIntersect*0.5*(settings.yMax+settings.doorWidth); %area near the door
AAgent = (4*rMax)^2; % area needed per Agent
buffer = 1; % add buffer to xMax
if settings.NAgent*AAgent < ADoor
    xMax = max((-settings.doorWidth+sqrt(settings.doorWidth^2+4*settings.NAgent*AAgent/tan(settings.wallAngle)))/(2/tan(settings.wallAngle)), (-settings.doorWidth-sqrt(settings.doorWidth^2+4*settings.NAgent*AAgent/tan(settings.wallAngle)))/(2/tan(settings.wallAngle)));
else
    xMax = XIntersect + (settings.NAgent*AAgent-ADoor)/(settings.yMax-2*settings.border);
end
xMax = ceil(xMax) + 2*settings.border + buffer;

end

