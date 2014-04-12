function newWallLineButtonUp( src, evnt )
%NEWWALLLINEBUTTONUP draws final wall line and stores new wall
thisfig = gcf();
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
handles = guidata(thisfig);

% figure out start and end point of line
startPoint = handles.temp.startPoint;
endPoint = get(gca,'CurrentPoint');
endPoint = endPoint(1,[1,2]);

newWallLine = [startPoint, endPoint];

handles.simulationObj.wallLines = [handles.simulationObj.wallLines; newWallLine];

% store wall id in wall drawings
hNewWallLine = handles.temp.hLine;
handles.plotObj.hWallLines = [handles.plotObj.hWallLines,hNewWallLine];
set(hNewWallLine, 'UserData', [3,length(handles.plotObj.hWallLines)]);

% tidy up
handles = rmfield(handles, 'temp');

% Update handles structure
guidata(thisfig, handles);
end

