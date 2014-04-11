function timerStopFunction( hObject )
%STOPFUNCTION Summary of this function goes here
%   Detailed explanation goes here
handles = guidata(hObject);
set(handles.captureButton, 'enable', 'on');
set(handles.resetButton, 'enable', 'on');
set(handles.fileMenu, 'enable', 'on');
set(handles.optionMenu, 'enable', 'on');
set(handles.playButton, 'TooltipString', 'Start the panic (p)');
set(handles.playButton, 'Value', 0); 

jButton = java(findjobj(handles.playButton));
myIcon = fullfile('./icons/play.png');
jButton.setIcon(javax.swing.ImageIcon(myIcon));

end

