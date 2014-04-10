function [ settings ] = setNAgent( settings, NAgent )
%SETNAGENT Summary of this function goes here
%   Detailed explanation goes here
settings.NAgent = NAgent;
if settings.xMaxCalcBool
    settings = setXMax(settings, calcXMax(settings));
end
end

