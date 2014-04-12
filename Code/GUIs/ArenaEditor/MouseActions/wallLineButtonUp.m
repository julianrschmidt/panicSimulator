function wallLineButtonUp( src, evnt )
%WALLLINEBUTTONUP saves new wall line coordinates of moved wall line
thisfig = gcf();
% delete functions earlier called when mouse was moved or button released
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
handles = guidata(thisfig);

% difference between current point and start point
xyDiff = get(gca,'CurrentPoint') - handles.temp.startpoint;
xyDiff = xyDiff(1,[1,2]);

% calculate new position field of wall line
newX = handles.temp.oldX + xyDiff(1);
newY = handles.temp.oldY + xyDiff(2);

set(handles.temp.currentWallLineHandle,'XData',newX);
set(handles.temp.currentWallLineHandle,'YData',newY);

% update wall line data
wallLines = handles.simulationObj.wallLines;
wallLines(handles.currentWallLineId,:) = ...
    [newX(1), newY(1), newX(2), newY(2)];
handles.simulationObj.wallLines = wallLines;

% delete temporary field 'temp' in handles
handles = rmfield(handles, 'temp');

% Update handles structure
guidata(thisfig, handles);
end

