function newWallLineButtonDown( src, evnt )
%NEWWALLLINEBUTTONDOWN prepares the creation of a line of wall
thisfig = gcf();
handles = guidata(thisfig);
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click

if strcmp(clickStyle, 'normal')
    startPoint = get(gca,'CurrentPoint');    
    startPoint = startPoint(1,[1,2]);
    hLine = plotWallLine([startPoint(1), startPoint(1)], [startPoint(2), startPoint(2)]);
    
    % store line and startPoint
    handles.temp.hLine = hLine;
    handles.temp.startPoint = startPoint;
    
    guidata(thisfig, handles);
    
    % set functions called when mouse is moved or released
    set(thisfig,'WindowButtonMotionFcn',@newWallLineButtonMoving);
    set(thisfig,'WindowButtonUpFcn',@newWallLineButtonUp);
    
elseif strcmp(clickStyle, 'alt')

end

end



