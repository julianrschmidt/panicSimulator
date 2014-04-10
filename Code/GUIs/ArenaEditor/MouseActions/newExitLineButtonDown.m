function newExitLineButtonDown( src, evnt )
%NEWEXITLINEBUTTONDOWN prepares the creation of a new exit line
thisfig = gcf();
handles = guidata(thisfig);
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click

if strcmp(clickStyle, 'normal')
    
    delete(handles.plotObj.hExit);
    
    startPoint = get(gca,'CurrentPoint');    
    startPoint = startPoint(1,[1,2]);
    hExit = plotExitLine([startPoint(1), startPoint(1)], [startPoint(2), startPoint(2)]);
    
    % store line and startPoint
    handles.temp.hExit = hExit;
    handles.temp.startPoint = startPoint;
    
    guidata(thisfig, handles);
    
    % set functions called when mouse is moved or released
    set(thisfig,'WindowButtonMotionFcn',@newExitLineButtonMoving);
    set(thisfig,'WindowButtonUpFcn',@newExitLineButtonUp);
    
elseif strcmp(clickStyle, 'alt')

end

end



