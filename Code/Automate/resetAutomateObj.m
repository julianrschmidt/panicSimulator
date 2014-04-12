function [ automateObj, settings ] = resetAutomateObj( automateObj, settings, automateNrReset )
%RESETAUTOMATEOBJ Resets all indices of the automateObj to initial
%   Also deletes stored times
%   automateNrReset: specifies which of the automate possiblities to reset
%                    if it is 0, all will be reset
% see also: CREATEAUTOMATEOBJ, AUTOMATE, DISPAUTOMATESTATUS
automateNrList = automateObj{1};
for automateObjIndex = 2:length(automateNrList) + 1
    automateNr = automateNrList(automateObjIndex-1);
    if (automateNr == automateNrReset || automateNrReset == 0)
        switch automateNr      
            % automatic change in velocity
            case 1            
                settings.vDes = automateObj{automateObjIndex}.vDesList(1);
                automateObj{automateObjIndex}.vDesIndex = 1;
                automateObj{automateObjIndex}.averageIndex = 1;
                automateObj{automateObjIndex}.timeNeeded = ...
                    zeros(1,length(automateObj{automateObjIndex}.vDesList));
            % automatic change in wall angle
            case 2
                settings = setWallAngle(settings,automateObj{automateObjIndex}.wallAngleList(1));
                automateObj{automateObjIndex}.wallAngleIndex = 1;
                automateObj{automateObjIndex}.averageIndex = 1;
                automateObj{automateObjIndex}.timeNeeded = ...
                    zeros(1,length(automateObj{automateObjIndex}.wallAngleList));
            % plot of individual exit times
            case 3
                automateObj{automateObjIndex}.timesAgentsThroughDoor = [];
        end
    end
end

