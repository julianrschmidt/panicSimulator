function wallLineButtonDown( src, evnt )
%WALLLINEBUTTONDOWN displays wall line information on left click
%   enables moving wall line when mouse is moved, 
%   deletes agent on right click

thisfig = gcbf();
handles = guidata(thisfig);
wallLines = handles.simulationObj.wallLines;
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click
% left click
if strcmp(clickStyle, 'normal')
    usrData = get(src, 'UserData');
    handles.currentWallLineId = usrData(2);

   
    % fill all agent information fields with agent information
    set(handles.idText, 'string', sprintf('%d', handles.currentWallLineId));
%     set(handles.xText, 'string', sprintf('%.2f', agents(handles.currentAgentId, 1)));
%     set(handles.yText, 'string', sprintf('%.2f', agents(handles.currentAgentId, 2)));
    
  
    % current coordinates of mouse in plot
    handles.temp.startpoint = get(gca,'CurrentPoint');        
    handles.temp.currentWallLineHandle = src;
    % current position of agent
    handles.temp.oldX = get(src, 'XData');
    handles.temp.oldY = get(src, 'YData');
    % Update handles structure
    guidata(thisfig, handles);
    % set functions called when mouse is moved or the mouse button released
    set(thisfig,'WindowButtonMotionFcn',@wallLineButtonMoving);
    set(thisfig,'WindowButtonUpFcn',@wallLineButtonUp);
% right click
elseif strcmp(clickStyle, 'alt')
    usrData = get(src, 'UserData');
    currentWallLineId = usrData(2);
    currentWallLineHandle = src;
    % delete all traces of agent
    delete(currentWallLineHandle);
    wallLines(currentWallLineId,:) = [];    
    handles.plotObj.hWallLines(currentWallLineId) = [];
    for j = (currentWallLineId):length(handles.plotObj.hWallLines);
        set(handles.plotObj.hWallLines(j), 'UserData', [3,j]);
    end
    handles.simulationObj.wallLines = wallLines;
    handles.currentWallLineId = 0;
    guidata(thisfig, handles);
end

end

