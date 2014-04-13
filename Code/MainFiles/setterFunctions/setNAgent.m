function [ settings ] = setNAgent( settings, NAgent )
%SETNAGENT changes NAgent in settings to desired value, also adapts xMax
settings.NAgent = NAgent;
if settings.xMaxCalcBool
    settings = setXMax(settings, calcXMax(settings));
end
end

