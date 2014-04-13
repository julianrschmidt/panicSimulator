function [ wallPoints ] = createCircleOfColumns( midPointX, midPointY, radius, columnRadiusMax )
%CREATECOLUMN creates a circle of columns
%   MIDPOINTX - x coordinate of circle center
%   MIDPOINTY - y coordinate of circle center
%   RADIUS - radius of circle of columns
%   WALLRADIUSMAX - radius of columns is never bigger than this value

NPoints = floor(pi*radius/columnRadiusMax); %number of wall points
wallRadius = pi*radius/NPoints;
wallPoints = zeros(NPoints,3); %initialize

for i = 1:NPoints
    xCoord = midPointX+radius*cos(i*2*pi/NPoints); %calculate wallPoints
    yCoord = midPointY+radius*sin(i*2*pi/NPoints); %calculate wallPoints
    
    wallPoints(i,:) = [xCoord, yCoord, wallRadius]; %update wallPoints
end
    
end

