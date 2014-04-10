function [ settings ] = setWallAngle( settings, wallAngle )
%SETWALLANGLE Summary of this function goes here
%   Detailed explanation goes here
settings.wallAngle = wallAngle;
if settings.xMaxCalcBool
    settings = setXMax(settings, calcXMax(settings));
end
end

