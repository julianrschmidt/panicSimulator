function timerStartFunction( hObject)
%TIMERSTARTFUNCTION does all necessary stuff when timer is first started
%   deactivates all uiControls apart from close and stop
%   Changes tooltip and icon of play/pause button

%deactivate all uiControls apart from close and stop
handles = guidata(hObject);
set(handles.captureButton, 'enable', 'off');
set(handles.resetButton, 'enable', 'off');
set(handles.fileMenu, 'enable', 'off');
set(handles.fileMenu, 'enable', 'off');
set(handles.optionMenu, 'enable', 'off');

% change tooltip and icon
set(handles.playButton, 'TooltipString', 'Stop the panic (p)');

jButton = java(findjobj(handles.playButton));
myIcon = fullfile('./icons/pause.png');
jButton.setIcon(javax.swing.ImageIcon(myIcon));
end

