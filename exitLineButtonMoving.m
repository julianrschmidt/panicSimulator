function exitLineButtonMoving( src, evnt )
%EXITLINEBUTTONMOVING moves clicked exit's line following mouse 
% movements
thisfig = gcf();
handles = guidata(thisfig);
% difference between current point and start point
xyDiff = get(gca,'CurrentPoint') - handles.temp.startpoint;
xyDiff = xyDiff(1,[1,2]);

% calculate new position field of agent
newXCurrentLine = handles.temp.oldXCurrentLine + xyDiff(1);
newYCurrentLine = handles.temp.oldYCurrentLine + xyDiff(2);
newXAdjacentLine = handles.temp.oldXAdjacentLine + xyDiff(1);
newYAdjacentLine = handles.temp.oldYAdjacentLine + xyDiff(2);

set(handles.temp.hCurrentLine,'XData',newXCurrentLine);
set(handles.temp.hCurrentLine,'YData',newYCurrentLine);
set(handles.temp.hAdjacentLine,'XData',newXAdjacentLine);
set(handles.temp.hAdjacentLine,'YData',newYAdjacentLine);

% Update handles structure
guidata(thisfig, handles);

end

