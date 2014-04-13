function [ color ] = colorMapPressure( pressure )
%COLORMAPPRESSURE returns a color related to a pressure value
%   a pressure of 0 will result in green
%   a pressure of 1500 will result in yellow
%   a pressure of 3000 will result in red
%   pressure values in between take color values in between

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

