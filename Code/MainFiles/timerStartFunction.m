function timerStartFunction( hObject)
%TIMERSTARTFUNCTION Summary of this function goes here
%   Detailed explanation goes here
handles = guidata(hObject);
set(handles.captureButton, 'enable', 'off');
set(handles.resetButton, 'enable', 'off');
set(handles.fileMenu, 'enable', 'off');
set(handles.fileMenu, 'enable', 'off');
set(handles.optionMenu, 'enable', 'off');

jButton = java(findjobj(handles.playButton));
myIcon = fullfile('./icons/pause.png');
jButton.setIcon(javax.swing.ImageIcon(myIcon));
end

