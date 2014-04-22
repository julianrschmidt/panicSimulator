function handles = resetProcedure(handles)
%RESETPROCEDURE executes all necessary tasks when a reset of the arena is
%done
% handles  -  structure with handles and user data (see GUIDATA)

% reset automateObj
[handles.automateObj] = resetAutomateObj(handles.automateObj);
handles.settings = modifySettingsDueToAutomateObj(handles.automateObj, handles.settings);
dispAutomateStatus(handles);

handles = resetProcedureWithoutAutomate(handles);

end

