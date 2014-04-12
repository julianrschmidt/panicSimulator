function handles = statistic( handles )
%STATISTIC Summary of this function goes here
%   Detailed explanation goes here
settings = handles.settings;
settingsNew = settings;
statisticObj = handles.statisticObj;
simulationObj = handles.simulationObj;
statisticNrList = statisticObj{1};
exitCoord = simulationObj.exitCoord;
resetBool = false;
for index = 2:length(statisticNrList) + 1
    statisticNr = statisticNrList(index - 1);
    switch statisticNr
        case 1
            if sum(isLeft(exitCoord(1:2),exitCoord(3:4), simulationObj.agents(:,1:2))) == 0
                
                averageIndex = statisticObj{index}.averageIndex;
                vDesIndex = statisticObj{index}.vDesIndex;
                
                statisticObj{index}.timeNeeded(vDesIndex) = statisticObj{index}.timeNeeded(vDesIndex) + simulationObj.tSimulation;
                
                averageIndex = averageIndex + 1;
                
                if averageIndex > statisticObj{index}.averageN
                    statisticObj{index}.timeNeeded(vDesIndex) = statisticObj{index}.timeNeeded(vDesIndex)/statisticObj{index}.averageN;
                    averageIndex = 1;
                    vDesIndex = vDesIndex + 1;
                end
                if vDesIndex <= length(statisticObj{index}.vDesList)
                    settingsNew.vDes = statisticObj{index}.vDesList(vDesIndex);
                    resetBool = true;
                                     
                    %save all variables in statistic object
                    statisticObj{index}.averageIndex = averageIndex;
                    statisticObj{index}.vDesIndex = vDesIndex;

                    handles.statisticObj = statisticObj;
                else      
                    figure;
                    plotStatistic1(statisticObj{index}); 
                    
                    [handles.statisticObj, settingsNew] = resetStatisticObj(handles.statisticObj, handles.settings, 1);
                    resetBool = true;

                    stop(handles.timerObj);                
                end
            end     
        case 2
            if sum(isLeft(exitCoord(1:2),exitCoord(3:4), simulationObj.agents(:,1:2))) == 0
                averageIndex = statisticObj{index}.averageIndex;
                wallAngleIndex = statisticObj{index}.wallAngleIndex;
                statisticObj{index}.timeNeeded(wallAngleIndex) = statisticObj{index}.timeNeeded(wallAngleIndex) + simulationObj.tSimulation;
                
                averageIndex = averageIndex + 1;
                
                if averageIndex > statisticObj{index}.averageN
                    statisticObj{index}.timeNeeded(wallAngleIndex) = statisticObj{index}.timeNeeded(wallAngleIndex)/statisticObj{index}.averageN;
                    averageIndex = 1;
                    wallAngleIndex = wallAngleIndex + 1;
                end
                if wallAngleIndex <= length(statisticObj{index}.wallAngleList)
                    settingsNew = setWallAngle(settings,statisticObj{index}.wallAngleList(wallAngleIndex));
                    resetBool = true;                    
                    
                    %save all variables in statistic object
                    statisticObj{index}.averageIndex = averageIndex;
                    statisticObj{index}.wallAngleIndex = wallAngleIndex;

                    handles.statisticObj = statisticObj;
                else   
                    figure;
                    plotStatistic2(statisticObj{index});      
                    
                    [handles.statisticObj, settingsNew] = resetStatisticObj(handles.statisticObj, handles.settings, 2);
                    resetBool = true;

                    stop(handles.timerObj);           
                end
            end
        case 3
            if sum(isLeft(exitCoord(1:2),exitCoord(3:4), simulationObj.agents(:,1:2))) == 0
                statisticObj{index}.timesAgentsThroughDoor = handles.simulationObj.timesAgentsThroughDoor;
                handles.statisticObj{index} = plotStatistic3(statisticObj{index});
                [handles.statisticObj, handles.settings] = resetStatisticObj(handles.statisticObj, handles.settings, 3);
                
                if sum(statisticNrList == 1) + sum(statisticNrList ==2) == 0
                    resetBool = true;
                    stop(handles.timerObj);                      
                end
                
            end
    end
    
end

settings = settingsNew;

if resetBool
    simulationObj = initArena(settings, simulationObj);
    simulationObj = initSimulationObj(simulationObj);
    set(handles.timeText, 'string', secondsToTimeString(0));

    plotObj = handles.plotObj;
    delete(plotObj.hCells);
    delete(plotObj.hAgents);
    delete(plotObj.hWalls);     
    delete(plotObj.hWallLines);
    plotObj = plotInit(simulationObj, settings, handles.figure1);

    handles.simulationObj = simulationObj;
    handles.plotObj = plotObj;
end

handles.settings = settings;
end

