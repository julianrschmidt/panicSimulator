function columnButtonUp( src, evnt )
%COLUMNBUTTONUP saves new wall coordinates of moved column
thisfig = gcf();
% delete functions earlier called when mouse was moved or button released
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
handles = guidata(thisfig);

% difference between current point and start point
xyDiff = get(gca,'CurrentPoint') - handles.temp.startpoint;
xyDiff = xyDiff(1,[1,2]);
% update wall data
handles.simulationObj.columns(handles.currentWallId,[1 2]) = ...
    handles.simulationObj.columns(handles.currentWallId,[1 2]) + xyDiff;

% update x and y text fields
set(handles.xText, 'string', sprintf('%.2f', handles.simulationObj.columns(handles.currentWallId, 1)));
set(handles.yText, 'string', sprintf('%.2f', handles.simulationObj.columns(handles.currentWallId, 2)));

% delete temporary field 'temp' in handles
handles = rmfield(handles, 'temp');

% Update handles structure
guidata(thisfig, handles);
end

