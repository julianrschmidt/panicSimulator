function circleOfColumnsButtonMoving( src, evnt )
%CIRCLEOFCOLUMNSBUTTONMOVING modifes the circle which was drawn and stored by
% circleOfColumnsButtonDown
thisfig = gcf();
handles = guidata(thisfig);
startPoint = handles.temp.startPoint;
currentPoint = get(gca,'CurrentPoint');
currentPoint = currentPoint(1,[1,2]);

r = norm(currentPoint - startPoint);

set(handles.temp.hCircle,'Position', [startPoint(1) - r, startPoint(2) - r, 2*r, 2*r]);

guidata(thisfig, handles);

end

