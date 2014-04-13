function [ settings ] = setWallAngle( settings, wallAngle )
%SETWALLANGLE changes wall angle to desired value, also adapts xMax
settings.wallAngle = wallAngle;
if settings.xMaxCalcBool
    settings = setXMax(settings, calcXMax(settings));
end
end

