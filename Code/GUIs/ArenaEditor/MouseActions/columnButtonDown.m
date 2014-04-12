function columnButtonDown( src, evnt )
%COLUMNBUTTONDOWN displays column information on left click
%   enables moving wall when mouse is moved, deletes wall on right click
thisfig = gcbf();
handles = guidata(thisfig);
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click
                                         
columns = handles.simulationObj.columns;
% left click
if strcmp(clickStyle, 'normal')
    usrData = get(src, 'UserData');
    handles.currentWallId = usrData(2);
    
    % enable all wall edit fields
    set(handles.wallRadiusEdit, 'enable', 'on');
    
    % fill all wall information fields with wall information
    set(handles.idText, 'string', sprintf('%d', handles.currentWallId));
    set(handles.xText, 'string', sprintf('%.2f', columns(handles.currentWallId, 1)));
    set(handles.yText, 'string', sprintf('%.2f', columns(handles.currentWallId, 2)));
   
    % obtain all information about wall
    radius = columns(handles.currentWallId, 3);
    % fill all wall edit fields with wall information
    set(handles.wallRadiusEdit, 'string', sprintf('%.2f', radius));  
    handles.lastValidEditValues.wallRadius = radius;
    
    % current coordinates of mouse in plot
    handles.temp.startpoint = get(gca,'CurrentPoint');    
    
    % current position of wall
    handles.temp.currentWallHandle = src;
    handles.temp.oldPos = get(src, 'Position');
    % Update handles structure
    guidata(thisfig, handles);
    % set functions called when mouse is moved or the mouse button released
    set(thisfig,'WindowButtonMotionFcn',@columnButtonMoving);
    set(thisfig,'WindowButtonUpFcn',@columnButtonUp);
% right click
elseif strcmp(clickStyle, 'alt')
    usrData = get(src, 'UserData');
    currentWallId = usrData(2);
    currentWallHandle = src;
    % delete all traces of wall
    delete(currentWallHandle);
    columns(currentWallId,:) = [];    
    handles.plotObj.hColumns(currentWallId) = [];
    for j = (currentWallId):length(handles.plotObj.hColumns);
        set(handles.plotObj.hColumns(j), 'UserData', [2,j]);
    end
    handles.currentWallId = 0;
    handles.simulationObj.columns = columns;
    % Update handles structure
    guidata(thisfig, handles);
end

end

