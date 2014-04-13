function timerStopFunction( hObject )
%TIMERSTOPFUNCTION does all necessary stuff when timer is first started
%   reactivates all uiControls
%   Changes tooltip and icon of play/pause button

%reactivate all uiControls apart from close and stop
handles = guidata(hObject);
set(handles.captureButton, 'enable', 'on');
set(handles.resetButton, 'enable', 'on');
set(handles.fileMenu, 'enable', 'on');
set(handles.optionMenu, 'enable', 'on');
set(handles.playButton, 'TooltipString', 'Start the panic (p)');
set(handles.playButton, 'Value', 0); 

% change tooltip and icon
jButton = java(findjobj(handles.playButton));
myIcon = fullfile('./icons/play.png');
jButton.setIcon(javax.swing.ImageIcon(myIcon));

end

