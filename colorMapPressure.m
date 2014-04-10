function [ color ] = colorMapPressure( pressure )
%COLORMAPPRESSURE Summary of this function goes here
%   Detailed explanation goes here

forestGreen = [34,139,34]/255;
yellow = [255, 255, 0]/255;
red = [255, 0, 0]/255;

maxPressure = 3000;
middlePressure = 1500;
minPressure = 0;

if pressure < minPressure
    color = forestGreen;
elseif pressure < middlePressure
    percentage = (pressure-minPressure)/(middlePressure-minPressure);
    color = percentage*yellow + (1-percentage)*forestGreen;
elseif pressure < maxPressure
    percentage = (pressure-middlePressure)/(maxPressure-middlePressure);
    color = percentage*red + (1-percentage)*yellow;
else
    color = red;
end

end

