function [handles, resetBool] = automate( handles )
%AUTOMATE Should be executed after time step of ode
%   Executes all necessary things for the automatization specified by the
%   user. For example it changes the settings after a run has been completed
%   if resetBool = true, the arena should be reset, but not the automateObj
% see also: CREATEAUTOMATEOBJ, RESETAUTOMATEOBJ, DISPAUTOMATEOBJ

% store some variables locally
settings = handles.settings;
automateObj = handles.automateObj;
simulationObj = handles.simulationObj;
exitCoord = simulationObj.exitCoord;
resetBool = false;

activeAutomatedVariable = automateObj.activeAutomatedVariable;

if ~strcmp(activeAutomatedVariable, 'none')
    % all agents right of door?
    if sum(isLeft(exitCoord(1:2),exitCoord(3:4), simulationObj.agents(:,1:2))) == 0
        resetBool = true;
        automateObj.exitTimes(automateObj.rangeIndex) = automateObj.exitTimes(automateObj.rangeIndex) + simulationObj.tSimulation;
        automateObj.averageIndex = automateObj.averageIndex + 1;
        % all averages taken?
        if automateObj.averageIndex > automateObj.averageN
            automateObj.exitTimes(automateObj.rangeIndex) = automateObj.exitTimes(automateObj.rangeIndex)/automateObj.averageN;
            automateObj.averageIndex = 1;
            automateObj.rangeIndex = automateObj.rangeIndex + 1;
        end
        % not the end of automatization
        if automateObj.rangeIndex <= length(automateObj.variableRange)
            val = automateObj.variableRange(automateObj.rangeIndex);
            setterFunc = automateObj.possibleAutomatedVariables.(automateObj.activeAutomatedVariable){4};
            settings = setterFunc(settings, val);
        % end of automatization
        else      
            % plot results
            figure;
            plotAutomate(automateObj); 
            automateObj = resetAutomateObj(automateObj);
            settings = modifySettingsDueToAutomateObj(automateObj, settings);
            stop(handles.timerObj);                
        end
    end
end
if automateObj.plotIndividualExitTimesBool
    % all agents right of door?
    if sum(isLeft(exitCoord(1:2),exitCoord(3:4), simulationObj.agents(:,1:2))) == 0
        automateObj.individualExitTimes = handles.simulationObj.timesAgentsThroughDoor;
        automateObj = plotIndividualExitTimes(automateObj);
        automateObj.individualExitTimes = [];
        % stop the simulation if none of the other automatizations
        % are running
        if strcmp(activeAutomatedVariable, 'none')
            resetBool = true;
            stop(handles.timerObj);                      
        end
    end    
end
handles.automateObj = automateObj;
handles.settings = settings;
end

