function newExitLineButtonUp( src, evnt )
%NEWEXITLINEBUTTONUP stores new exit data
thisfig = gcf();
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
handles = guidata(thisfig);

% figure out start and end point of line
startPoint = handles.temp.startPoint;
endPoint = get(gca,'CurrentPoint');
endPoint = endPoint(1,[1,2]);

handles.simulationObj.exitCoord = [startPoint, endPoint];

% store wall id in wall drawings
handles.plotObj.hExit = handles.temp.hExit;
set(handles.temp.hExit(1), 'UserData', [4, handles.temp.hExit(2)]);
set(handles.temp.hExit(2), 'UserData', [4, handles.temp.hExit(1)]);

% tidy up
handles = rmfield(handles, 'temp');

% Update handles structure
guidata(thisfig, handles);
end

