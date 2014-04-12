function [handles, resetBool] = automate( handles )
%AUTOMATE Should be executed after time step of ode
%   Executes all necessary things for the automatization specified by the
%   user. For example it changes the settings after a run has been completed
%   if resetBool = true, the arena should be reset, but not the automateObj
% see also: CREATEAUTOMATEOBJ, RESETAUTOMATEOBJ, DISPAUTOMATEOBJ

% store some variables locally
settings = handles.settings;
settingsNew = settings;
automateObj = handles.automateObj;
simulationObj = handles.simulationObj;
automateNrList = automateObj{1};
exitCoord = simulationObj.exitCoord;
resetBool = false;

% loop through all automate objects
for index = 2:length(automateNrList) + 1
    automateNr = automateNrList(index - 1);
    switch automateNr
        % automatic change in velocity
        case 1
            % all agents right of door?
            if sum(isLeft(exitCoord(1:2),exitCoord(3:4), simulationObj.agents(:,1:2))) == 0
                
                averageIndex = automateObj{index}.averageIndex;
                vDesIndex = automateObj{index}.vDesIndex;
                
                automateObj{index}.timeNeeded(vDesIndex) = automateObj{index}.timeNeeded(vDesIndex) + simulationObj.tSimulation;
                
                averageIndex = averageIndex + 1;
                
                % all averages taken?
                if averageIndex > automateObj{index}.averageN
                    automateObj{index}.timeNeeded(vDesIndex) = automateObj{index}.timeNeeded(vDesIndex)/automateObj{index}.averageN;
                    averageIndex = 1;
                    vDesIndex = vDesIndex + 1;
                end
                % not the end of automatization
                if vDesIndex <= length(automateObj{index}.vDesList)
                    settingsNew.vDes = automateObj{index}.vDesList(vDesIndex);
                    resetBool = true;
                                     
                    %save all variables in automate object
                    automateObj{index}.averageIndex = averageIndex;
                    automateObj{index}.vDesIndex = vDesIndex;

                    handles.automateObj = automateObj;
                % end of automatization
                else      
                    % plot results
                    figure;
                    plotAutomate1(automateObj{index}); 
                    
                    [handles.automateObj, settingsNew] = resetAutomateObj(handles.automateObj, handles.settings, 1);
                    resetBool = true;

                    stop(handles.timerObj);                
                end
            end   
        % automatic change in wall angle
        case 2
            % all agents right of door?
            if sum(isLeft(exitCoord(1:2),exitCoord(3:4), simulationObj.agents(:,1:2))) == 0
                averageIndex = automateObj{index}.averageIndex;
                wallAngleIndex = automateObj{index}.wallAngleIndex;
                automateObj{index}.timeNeeded(wallAngleIndex) = automateObj{index}.timeNeeded(wallAngleIndex) + simulationObj.tSimulation;
                
                averageIndex = averageIndex + 1;
                
                % all averages taken?
                if averageIndex > automateObj{index}.averageN
                    automateObj{index}.timeNeeded(wallAngleIndex) = automateObj{index}.timeNeeded(wallAngleIndex)/automateObj{index}.averageN;
                    averageIndex = 1;
                    wallAngleIndex = wallAngleIndex + 1;
                end
                % automatization not finished
                if wallAngleIndex <= length(automateObj{index}.wallAngleList)
                    settingsNew = setWallAngle(settings,automateObj{index}.wallAngleList(wallAngleIndex));
                    resetBool = true;                    
                    
                    %save all variables in automate object
                    automateObj{index}.averageIndex = averageIndex;
                    automateObj{index}.wallAngleIndex = wallAngleIndex;

                    handles.automateObj = automateObj;
                % automatization finished
                else   
                    % plot results
                    figure;
                    plotAutomate2(automateObj{index});      
                    
                    [handles.automateObj, settingsNew] = resetAutomateObj(handles.automateObj, handles.settings, 2);
                    resetBool = true;

                    stop(handles.timerObj);           
                end
            end
        % plot individual times when agents through door
        case 3
            % all agents right of door?
            if sum(isLeft(exitCoord(1:2),exitCoord(3:4), simulationObj.agents(:,1:2))) == 0
                automateObj{index}.timesAgentsThroughDoor = handles.simulationObj.timesAgentsThroughDoor;
                handles.automateObj{index} = plotAutomate3(automateObj{index});
                [handles.automateObj, handles.settings] = resetAutomateObj(handles.automateObj, handles.settings, 3);
                
                % stop the simulation if none of the other automatizations
                % are running
                if sum(automateNrList == 1) + sum(automateNrList ==2) == 0
                    resetBool = true;
                    stop(handles.timerObj);                      
                end
                
            end
    end
    
end

settings = settingsNew;

if resetBool
    simulationObj = createSimulationObj(settings, simulationObj);
    simulationObj = resetSimulationObj(simulationObj);
    set(handles.timeText, 'string', secondsToTimeString(0));

    plotObj = handles.plotObj;
    delete(plotObj.hCells);
    delete(plotObj.hAgents);
    delete(plotObj.hColumns);     
    delete(plotObj.hWallLines);
    plotObj = plotInit(simulationObj, settings, handles.figure1);

    handles.simulationObj = simulationObj;
    handles.plotObj = plotObj;
end

handles.settings = settings;
end

