function objectButtonDown( src, evnt )
%OBJECTBUTTONDOWN executes common button down tasks and calls appropriate
%  buttonDown functions

thisfig = gcbf();
handles = guidata(thisfig);
% some general tidying up
set(handles.agentRadiusEdit, 'enable', 'off');
set(handles.agentVelocityEdit, 'enable', 'off');
set(handles.agentDirectionEdit, 'enable', 'off');
set(handles.wallRadiusEdit, 'enable', 'off');
set(handles.idText, 'string', sprintf('-'));
set(handles.xText, 'string', sprintf('-'));
set(handles.yText, 'string', sprintf('-'));
handles.currentAgentId = 0;
handles.currentWallId = 0;
handles.currentWallLineId = 0;
guidata(thisfig, handles);
usrData = get(src, 'UserData');
objectType = usrData(1);
switch objectType
    case 1
        agentButtonDown(src, evnt);
    case 2
        columnButtonDown(src, evnt);
    case 3
        wallLineButtonDown(src, evnt);
    case 4
        exitLineButtonDown(src, evnt);
end
        
end