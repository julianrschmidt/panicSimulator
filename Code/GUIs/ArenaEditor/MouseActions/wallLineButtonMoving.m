function wallLineButtonMoving( src, evnt )
%WALLLINEBUTTONMOVING moves current clicked wall line following mouse 
%   movements
thisfig = gcf();
handles = guidata(thisfig);
% difference between current point and start point
xyDiff = get(gca,'CurrentPoint') - handles.temp.startpoint;
xyDiff = xyDiff(1,[1,2]);

% calculate new position field of wall line
newX = handles.temp.oldX + xyDiff(1);
newY = handles.temp.oldY + xyDiff(2);

set(handles.temp.currentWallLineHandle,'XData',newX);
set(handles.temp.currentWallLineHandle,'YData',newY);

% Update handles structure
guidata(thisfig, handles);

end

