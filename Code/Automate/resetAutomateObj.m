function [ automateObj, settings ] = resetAutomateObj( automateObj, settings, automateNrReset )
%RESETAUTOMATEOBJ Summary of this function goes here
%   Detailed explanation goes here
automateNrList = automateObj{1};
for automateObjIndex = 2:length(automateNrList) + 1
    automateNr = automateNrList(automateObjIndex-1);
    if (automateNr == automateNrReset || automateNrReset == 0)
        switch automateNr        
            case 1            
                settings.vDes = automateObj{automateObjIndex}.vDesList(1);
                automateObj{automateObjIndex}.vDesIndex = 1;
                automateObj{automateObjIndex}.averageIndex = 1;
                automateObj{automateObjIndex}.timeNeeded = ...
                    zeros(1,length(automateObj{automateObjIndex}.vDesList));
            case 2
                settings = setWallAngle(settings,automateObj{automateObjIndex}.wallAngleList(1));
                automateObj{automateObjIndex}.wallAngleIndex = 1;
                automateObj{automateObjIndex}.averageIndex = 1;
                automateObj{automateObjIndex}.timeNeeded = ...
                    zeros(1,length(automateObj{automateObjIndex}.wallAngleList));
            case 3
                automateObj{automateObjIndex}.timesAgentsThroughDoor = [];
        end
    end
end

