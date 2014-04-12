function circleOfColumnsButtonDown( src, evnt )
%CIRCLEOFCOLUMNSBUTTONDOWN prepares the creation of a line of wall
thisfig = gcf();
handles = guidata(thisfig);
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click
if strcmp(clickStyle, 'normal')
    startPoint = get(gca,'CurrentPoint');    
    startPoint = startPoint(1,[1,2]);
    % draw a line, such that user can see where the line of wall will be
    % line will be deleted in lineOfColumnsButtonUp
    hCircle = rectangle('Position',[startPoint(1), startPoint(2), eps, eps],...
        'Curvature',[1,1], 'FaceColor','none', 'edgeColor','b');
    
    % store line and startPoint
    handles.temp.hCircle = hCircle;
    handles.temp.startPoint = startPoint;
    
    guidata(thisfig, handles);
    
    % set functions called when mouse is moved or released
    set(thisfig,'WindowButtonMotionFcn',@circleOfColumnsButtonMoving);
    set(thisfig,'WindowButtonUpFcn',@circleOfColumnsButtonUp);
    
elseif strcmp(clickStyle, 'alt')

end

end



