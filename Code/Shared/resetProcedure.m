function handles = resetProcedure(handles)
%RESETPROCEDURE executes all necessary tasks when a reset of the arena is
%done
% handles  -  structure with handles and user data (see GUIDATA)

% reset automateObj
[handles.automateObj, handles.settings] = ...
    resetAutomateObj(handles.automateObj, handles.settings, 0);
dispAutomateStatus(handles);

handles = resetProcedureWithoutAutomate(handles);

end

