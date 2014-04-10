function exitLineButtonUp( src, evnt )
%EXITLINEBUTTONUP saves new exit coordinates of moved exit
thisfig = gcf();
% delete functions earlier called when mouse was moved or button released
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
handles = guidata(thisfig);

% difference between current point and start point
xyDiff = get(gca,'CurrentPoint') - handles.temp.startpoint;
xyDiff = xyDiff(1,[1,2]);

% update exit data
exitCoord = handles.simulationObj.exitCoord;
exitCoord([1 3]) = exitCoord([1 3]) + xyDiff(1);
exitCoord([2 4]) = exitCoord([2 4]) + xyDiff(2);
handles.simulationObj.exitCoord = exitCoord;

% delete temporary field 'temp' in handles
handles = rmfield(handles, 'temp');

% Update handles structure
guidata(thisfig, handles);
end

