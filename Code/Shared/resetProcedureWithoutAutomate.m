function handles = resetProcedureWithoutAutomate(handles)
%RESETPROCEDUREWITHOUTAUTOMATE executes all necessary tasks when a reset 
% of the arena is done but does not reset the automateObj
% handles  -  structure with handles and user data (see GUIDATA)

%reset timer
set(handles.timeText, 'string', secondsToTimeString(0));

%generate agents, columns in dependence on settings
simulationObj = createSimulationObj(handles.settings, cell(0));

% reset the simulationObj
simulationObj = resetSimulationObj(simulationObj);

% delete old plot
plotObj = handles.plotObj;
delete(plotObj.hCells);
delete(plotObj.hAgents(:));
delete(plotObj.hColumns(:));
delete(plotObj.hWallLines(:));
delete(plotObj.hExit(:));
% plot everything
plotObj = plotInit(simulationObj, handles.settings, handles.figure1);
% store everything
handles.simulationObj = simulationObj;
handles.plotObj = plotObj;

end

