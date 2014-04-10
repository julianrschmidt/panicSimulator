function newWallLineButtonMoving( src, evnt )
%NEWWALLLINEBUTTONMOVING modifes the line which was drawn and stored by
% newWallLineButtonDown
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

set(handles.temp.hLine,'XData', [x'-nx*thickness/2;x(2:-1:1)'+nx*thickness/2]);
set(handles.temp.hLine,'YData', [y'-ny*thickness/2;y(2:-1:1)'+ny*thickness/2]);

guidata(thisfig, handles);

end

