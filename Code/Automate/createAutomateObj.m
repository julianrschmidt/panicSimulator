function [ automateObj, settings ] = createAutomateObj( automateNrList, settings )
%CREATEAUTOMATEOBJ creates an automateObj, dependent on settings
%   exit times and current runs are stored in here
%   automateNrList: array of all automate Numbers, which are supposed to be
%                   generated
%    possible values: 1 - automatic change in velocity
%                     2 - automatic change in wall angle
%                     3 - plot of individual exit times
% see also: AUTOMATE, RESETAUTOMATEOBJ, DISPAUTOMATEOBJ
automateObj = cell(length(automateNrList) + 1,1);
automateObj{1} = automateNrList;
for automateObjIndex = 2:length(automateNrList) + 1
    automateNr = automateNrList(automateObjIndex-1);
    automateObj{automateObjIndex}.automateNr = automateNr;
    %  automatic change in velocity
    switch automateNr
        case 1            
            automateObj{automateObjIndex}.vDesList = linspace(1,10,10);
            settings.vDes = automateObj{automateObjIndex}.vDesList(1);
            automateObj{automateObjIndex}.vDesIndex = 1;
            automateObj{automateObjIndex}.averageIndex = 1;
            automateObj{automateObjIndex}.averageN = 5;
            automateObj{automateObjIndex}.timeNeeded = ...
                zeros(1,length(automateObj{automateObjIndex}.vDesList));
        %  automatic change in wall angle
        case 2
            automateObj{automateObjIndex}.wallAngleList = linspace(0,pi/2,5);
            settings.wallAngle = automateObj{automateObjIndex}.wallAngleList(1);
            automateObj{automateObjIndex}.wallAngleIndex = 1;
            automateObj{automateObjIndex}.averageIndex = 1;
            automateObj{automateObjIndex}.averageN = 5;
            automateObj{automateObjIndex}.timeNeeded = ...
                zeros(1,length(automateObj{automateObjIndex}.wallAngleList));
        % plot of individual exit times
        case 3
            automateObj{automateObjIndex}.timesAgentsThroughDoor = [];
            automateObj{automateObjIndex}.hFig = [];
            automateObj{automateObjIndex}.runN = 1;
    end
end

end

