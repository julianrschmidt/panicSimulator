function newExitLineButtonMoving( src, evnt )
%NEWEXITLINEBUTTONMOVING modifes the line which was drawn and stored by
% newExitLineButtonDown
thisfig = gcf();
handles = guidata(thisfig);
startPoint = handles.temp.startPoint;
currentPoint = get(gca,'CurrentPoint');
currentPoint = currentPoint(1,[1,2]);

x = [startPoint(1), currentPoint(1)];
y = [startPoint(2), currentPoint(2)];

thickness = 0.3; %thickness of door in cm
nx = y(1) - y(2);
ny = x(2) - x(1);
nLength = sqrt(nx.^2 + ny.^2);
nx = nx./nLength;
ny = ny./nLength;

set(handles.temp.hExit(1),'XData', [x';x(2:-1:1)'+nx*thickness/2]);
set(handles.temp.hExit(1),'YData', [y';y(2:-1:1)'+ny*thickness/2]);
set(handles.temp.hExit(2),'XData', [x';x(2:-1:1)'-nx*thickness/2]);
set(handles.temp.hExit(2),'YData', [y';y(2:-1:1)'-ny*thickness/2]);

guidata(thisfig, handles);

end

