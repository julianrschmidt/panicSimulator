function updateAndPlot( hObject)
%UPDATEANDPLOT calls the updateAgent function and plots the new matrix if
% necessary, also captures the plot if captureBool == true
handles = guidata(hObject);
settings = handles.settings;
simulationObj = handles.simulationObj;
hAgents = handles.plotObj.hAgents;
captureBool = handles.captureBool;

if size(handles.simulationObj.agents, 1) ~= 0

    % t1 = tic;
    simulationObj = updateAgents(simulationObj, settings, hObject);
    % toc(t1);

    plotUpdate(hAgents, simulationObj.agents, simulationObj.pressure);
    drawnow;
    if (captureBool)
        writeVideo(handles.videoObj, getframe(handles.axes1));
    end

    handles.simulationObj = simulationObj;
    set(handles.timeText, 'string', secondsToTimeString(simulationObj.tSimulation));
    guidata(hObject, handles);
    statistic(hObject, handles);
end

end

