function [ statisticObj, settings ] = resetStatisticObj( statisticObj, settings, statisticNrReset )
%RESETSTATISTICOBJ Summary of this function goes here
%   Detailed explanation goes here
statisticNrList = statisticObj{1};
for statisticObjIndex = 2:length(statisticNrList) + 1
    statisticNr = statisticNrList(statisticObjIndex-1);
    if (statisticNr == statisticNrReset || statisticNrReset == 0)
        switch statisticNr        
            case 1            
                settings.vDes = statisticObj{statisticObjIndex}.vDesList(1);
                statisticObj{statisticObjIndex}.vDesIndex = 1;
                statisticObj{statisticObjIndex}.averageIndex = 1;
                statisticObj{statisticObjIndex}.timeNeeded = ...
                    zeros(1,length(statisticObj{statisticObjIndex}.vDesList));
            case 2
                settings = setWallAngle(settings,statisticObj{statisticObjIndex}.wallAngleList(1));
                statisticObj{statisticObjIndex}.wallAngleIndex = 1;
                statisticObj{statisticObjIndex}.averageIndex = 1;
                statisticObj{statisticObjIndex}.timeNeeded = ...
                    zeros(1,length(statisticObj{statisticObjIndex}.wallAngleList));
            case 3
                statisticObj{statisticObjIndex}.timesAgentsThroughDoor = [];
        end
    end
end

