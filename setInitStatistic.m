function [ statisticObj, settings ] = setInitStatistic( statisticNrList, settings )
%SETINITSTATISTIC Summary of this function goes here
%   Detailed explanation goes here
statisticObj = cell(length(statisticNrList) + 1,1);
statisticObj{1} = statisticNrList;
for statisticObjIndex = 2:length(statisticNrList) + 1
    statisticNr = statisticNrList(statisticObjIndex-1);
    statisticObj{statisticObjIndex}.statisticNr = statisticNr;
    switch statisticNr
        case 1            
            statisticObj{statisticObjIndex}.vDesList = linspace(1,10,10);
            settings.vDes = statisticObj{statisticObjIndex}.vDesList(1);
            statisticObj{statisticObjIndex}.vDesIndex = 1;
            statisticObj{statisticObjIndex}.averageIndex = 1;
            statisticObj{statisticObjIndex}.averageN = 5;
            statisticObj{statisticObjIndex}.timeNeeded = ...
                zeros(1,length(statisticObj{statisticObjIndex}.vDesList));
        case 2
            statisticObj{statisticObjIndex}.wallAngleList = linspace(0,pi/2,5);
            settings.wallAngle = statisticObj{statisticObjIndex}.wallAngleList(1);
            statisticObj{statisticObjIndex}.wallAngleIndex = 1;
            statisticObj{statisticObjIndex}.averageIndex = 1;
            statisticObj{statisticObjIndex}.averageN = 5;
            statisticObj{statisticObjIndex}.timeNeeded = ...
                zeros(1,length(statisticObj{statisticObjIndex}.wallAngleList));
        case 3
            statisticObj{statisticObjIndex}.timesAgentsThroughDoor = [];
            statisticObj{statisticObjIndex}.hFig = [];
            statisticObj{statisticObjIndex}.runN = 1;
    end
end

end

