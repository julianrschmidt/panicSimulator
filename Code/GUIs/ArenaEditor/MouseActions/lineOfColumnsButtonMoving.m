function lineOfColumnsButtonMoving( src, evnt )
%LINEOFCOLUMNSBUTTONMOVING modifes the line which was drawn and stored by
% lineOfColumnsButtonDown
thisfig = gcf();
handles = guidata(thisfig);
startPoint = handles.temp.startPoint;
currentPoint = get(gca,'CurrentPoint');
currentPoint = currentPoint(1,[1,2]);

set(handles.temp.hLine,'XData', [startPoint(1), currentPoint(1)]);
set(handles.temp.hLine,'YData', [startPoint(2), currentPoint(2)]);

guidata(thisfig, handles);

end

