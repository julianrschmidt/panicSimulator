function exitLineButtonDown( src, evnt )
%EXITLINEBUTTONDOWN enables moving exit when mouse is moved

thisfig = gcbf();
handles = guidata(thisfig);
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click
% left click
if strcmp(clickStyle, 'normal')
    usrData = get(src, 'UserData');
%     handles.currentAgentId = usrData(2);
    hAdjacentLine = usrData(2);
    
    % current coordinates of mouse in plot
    handles.temp.startpoint = get(gca,'CurrentPoint');  
    handles.temp.hAdjacentLine = hAdjacentLine;
    handles.temp.hCurrentLine = src;
    % current position of agent
    handles.temp.oldXCurrentLine = get(src, 'XData');
    handles.temp.oldYCurrentLine = get(src, 'YData');
    handles.temp.oldXAdjacentLine = get(hAdjacentLine, 'XData');
    handles.temp.oldYAdjacentLine = get(hAdjacentLine, 'YData');
    
    % Update handles structure
    guidata(thisfig, handles);
    % set functions called when mouse is moved or the mouse button released
    set(thisfig,'WindowButtonMotionFcn',@exitLineButtonMoving);
    set(thisfig,'WindowButtonUpFcn',@exitLineButtonUp);
% right click
elseif strcmp(clickStyle, 'alt')
 
end

end

