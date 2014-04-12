function [ automateObj, settings ] = createAutomateObj( automateNrList, settings )
%CREATEAUTOMATEOBJ Summary of this function goes here
%   Detailed explanation goes here
automateObj = cell(length(automateNrList) + 1,1);
automateObj{1} = automateNrList;
for automateObjIndex = 2:length(automateNrList) + 1
    automateNr = automateNrList(automateObjIndex-1);
    automateObj{automateObjIndex}.automateNr = automateNr;
    switch automateNr
        case 1            
            automateObj{automateObjIndex}.vDesList = linspace(1,10,10);
            settings.vDes = automateObj{automateObjIndex}.vDesList(1);
            automateObj{automateObjIndex}.vDesIndex = 1;
            automateObj{automateObjIndex}.averageIndex = 1;
            automateObj{automateObjIndex}.averageN = 5;
            automateObj{automateObjIndex}.timeNeeded = ...
                zeros(1,length(automateObj{automateObjIndex}.vDesList));
        case 2
            automateObj{automateObjIndex}.wallAngleList = linspace(0,pi/2,5);
            settings.wallAngle = automateObj{automateObjIndex}.wallAngleList(1);
            automateObj{automateObjIndex}.wallAngleIndex = 1;
            automateObj{automateObjIndex}.averageIndex = 1;
            automateObj{automateObjIndex}.averageN = 5;
            automateObj{automateObjIndex}.timeNeeded = ...
                zeros(1,length(automateObj{automateObjIndex}.wallAngleList));
        case 3
            automateObj{automateObjIndex}.timesAgentsThroughDoor = [];
            automateObj{automateObjIndex}.hFig = [];
            automateObj{automateObjIndex}.runN = 1;
    end
end

end

