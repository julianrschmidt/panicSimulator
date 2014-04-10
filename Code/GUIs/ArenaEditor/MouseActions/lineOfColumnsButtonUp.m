function lineOfColumnsButtonUp( src, evnt )
%LINEOFCOLUMNSBUTTONUP delete line drawn by lineOfColumnsButtonDown, draw line of
%walls and store new wall objects in the walls matrix
thisfig = gcf();
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
handles = guidata(thisfig);

% figure out start and end point of line
startPoint = handles.temp.startPoint;
endPoint = get(gca,'CurrentPoint');
endPoint = endPoint(1,[1,2]);
% delete line drawn by lineOfColumnsButtonDown
delete(handles.temp.hLine);

% get maximum radius of walls
radiusMax = str2double(get(handles.wallRadiusEdit, 'String'));

% generate line of walls
newWalls = generateWallLine(startPoint(1), startPoint(2), endPoint(1), endPoint(2), radiusMax);
handles.simulationObj.walls = [handles.simulationObj.walls; newWalls];

% store wall id in wall drawings
hNewWalls = zeros(1, size(newWalls, 1));
for j = 1:length(hNewWalls)
    hNewWalls(j) = plotWallCircle(newWalls(j,1), newWalls(j,2), newWalls(j,3));
    set(hNewWalls(j), 'UserData', [2,j + length(handles.plotObj.hWalls)]);
end

handles.plotObj.hWalls = [handles.plotObj.hWalls, hNewWalls];

% tidy up
handles = rmfield(handles, 'temp');

% Update handles structure
guidata(thisfig, handles);
end
