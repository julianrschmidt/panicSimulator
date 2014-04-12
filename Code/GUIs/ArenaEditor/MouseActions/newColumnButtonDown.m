function newColumnButtonDown( src, evnt )
%NEWCOLUMNBUTTONDOWN generates a new wall at current position of mouse
% with settings of edit fields
thisfig = gcf();
handles = guidata(thisfig);
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click

if strcmp(clickStyle, 'normal')
    % figure out current coordinates of mouse
    currentPoint = get(gca,'CurrentPoint');    
    currentPoint = currentPoint(1,[1,2]);
    
    % determine new wall id
    currentWallId = length(handles.plotObj.hColumns) + 1;
    % get all desired wall properties
    wallRadius = str2double(get(handles.wallRadiusEdit, 'String'));
    
    % store new wall
    newWall = [currentPoint, wallRadius];
    handles.simulationObj.columns = [handles.simulationObj.columns; newWall];
    
    % plot wall, save wall id and store wall handle
    hNewWall = plotWallColumn(newWall(1), newWall(2), newWall(3));
    handles.plotObj.hColumns = [handles.plotObj.hColumns, hNewWall];
    set(hNewWall, 'UserData', [2,currentWallId]);
    
    % update the object information text
    set(handles.idText, 'string', sprintf('%d', currentWallId));
    set(handles.xText, 'string', sprintf('%.2f', currentPoint(1)));
    set(handles.yText, 'string', sprintf('%.2f', currentPoint(2)));
    
    % Update handles structure
    guidata(thisfig, handles);
    
elseif strcmp(clickStyle, 'alt')

end

end



