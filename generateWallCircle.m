function [ wallPoints ] = generateWallCircle( midPointX, midPointY, radius, wallRadiusMax )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

NPoints = floor(pi*radius/wallRadiusMax); %number of wall points
wallRadius = pi*radius/NPoints;
wallPoints = zeros(NPoints,3); %initialize

for i = 1:NPoints
    xCoord = midPointX+radius*cos(i*2*pi/NPoints); %calculate wallPoints
    yCoord = midPointY+radius*sin(i*2*pi/NPoints); %calculate wallPoints
    
    wallPoints(i,:) = [xCoord, yCoord, wallRadius]; %update wallPoints
end
    
end

