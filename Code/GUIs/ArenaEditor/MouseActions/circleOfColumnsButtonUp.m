function circleOfColumnsButtonUp( src, evnt )
%CIRCLEOFCOLUMNSBUTTONUP delete line drawn by lineOfColumnsButtonDown, draw circle of
%columns and store new wall objects in the columns matrix
thisfig = gcf();
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
handles = guidata(thisfig);

% figure out start and end point of line
startPoint = handles.temp.startPoint;
endPoint = get(gca,'CurrentPoint');
endPoint = endPoint(1,[1,2]);
r = norm(endPoint-startPoint);
% delete line drawn by lineOfColumnsButtonDown
delete(handles.temp.hCircle);

% get maximum radius of columns
radiusMax = str2double(get(handles.wallRadiusEdit, 'String'));

% generate line of columns
newWalls = createCircleOfColumns(startPoint(1), startPoint(2), r, radiusMax);
handles.simulationObj.columns = [handles.simulationObj.columns; newWalls];

% store wall id in wall drawings
hNewWalls = zeros(1, size(newWalls, 1));
for j = 1:length(hNewWalls)
    hNewWalls(j) = plotWallColumn(newWalls(j,1), newWalls(j,2), newWalls(j,3));
    set(hNewWalls(j), 'UserData', [2,j + length(handles.plotObj.hColumns)]);
end

handles.plotObj.hColumns = [handles.plotObj.hColumns, hNewWalls];

% tidy up
handles = rmfield(handles, 'temp');

% Update handles structure
guidata(thisfig, handles);
end

