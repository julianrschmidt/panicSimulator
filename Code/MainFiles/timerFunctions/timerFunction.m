function timerFunction( hObject)
%TIMERFUNCTION calls the updateAgent function and plots the new matrix if
% necessary, also captures the plot if captureBool == true
handles = guidata(hObject);
settings = handles.settings;
simulationObj = handles.simulationObj;
hAgents = handles.plotObj.hAgents;
captureBool = handles.captureBool;

if size(handles.simulationObj.agents, 1) ~= 0

    % t1 = tic;
    simulationObj = agentsStep(simulationObj, settings, hObject);
    % toc(t1);

    plotUpdate(hAgents, simulationObj.agents, simulationObj.pressure);
    drawnow;
    if (captureBool)
		position = getpixelposition(handles.axes1) + 20*[-1, -1, 2, 2];
        writeVideo(handles.videoObj, getframe(handles.figure1, position));
    end

    handles.simulationObj = simulationObj;
    set(handles.timeText, 'string', secondsToTimeString(simulationObj.tSimulation));
    [handles, resetBool] = automate(handles);
    if resetBool
        handles = resetProcedureWithoutAutomate(handles);
    end
    dispAutomateStatus(handles);
    guidata(hObject, handles);    
end

end

