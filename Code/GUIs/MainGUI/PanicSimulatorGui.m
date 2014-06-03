function varargout = PanicSimulatorGui(varargin)
% PANICSIMULATORGUI MATLAB code for PanicSimulatorGui.fig
%      PANICSIMULATORGUI, by itself, creates a new PANICSIMULATORGUI or raises the existing
%      singleton*.
%
%      H = PANICSIMULATORGUI returns the handle to a new PANICSIMULATORGUI or the handle to
%      the existing singleton*.
%
%      *See PANICSIMULATORGUI Options on GUIDE's Tools menu.  Choose "PANICSIMULATORGUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified by GUIDE v2.5 12-Apr-2014 21:00:42

% Begin initialization code - DO NOT EDIT - created by GUIDE
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PanicSimulatorGui_OpeningFcn, ...
                   'gui_OutputFcn',  @PanicSimulatorGui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT - created by GUIDE


% --- Executes just before PanicSimulatorGui is made visible.
function PanicSimulatorGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PanicSimulatorGui (see VARARGIN)

% load or generate settings
if exist('presets/defaultSettings.mat', 'file') == 2
    if sum(strcmp(who('-file', 'presets/defaultSettings.mat'), 'settings')) == 1
        load('presets/defaultSettings.mat', 'settings');
        if validateSettings(settings)
        else
            settings = createDefaultSettings();   
        end
    else
        settings = createDefaultSettings();
    end
else
    settings = createDefaultSettings();
end

% load or generate automate object
if exist('presets/defaultAutomateSettings.mat', 'file') == 2
    if sum(strcmp(who('-file', 'presets/defaultAutomateSettings.mat'), 'automateObj')) == 1
        load('presets/defaultAutomateSettings.mat', 'automateObj');
        if validateAutomateObj(automateObj)
            settings = modifySettingsDueToAutomateObj(automateObj, settings);
        else
            automateObj = createAutomateObj();
        end
    else
        automateObj = createAutomateObj();
    end
else
    automateObj = createAutomateObj();
end

% true if drawn images are captured
handles.captureBool = false;
%generates simulationObj (agents and walls) in dependence on settings
simulationObj = createSimulationObj(settings, cell(0));

%set time for simulation and plot
simulationObj = resetSimulationObj(simulationObj);

%plot everything
plotObj = plotInit(simulationObj, settings, handles.figure1);

%create timerfunction for playing and stopping simulation
timerFcn = @(hObj, event) timerFunction(hObject);
if settings.realTimeBool
    % interval, in which the timer is called once
    period = max(0.001,settings.dtPlot); 
else
    period = 0.001;
end
timerObj = timer('TimerFcn', timerFcn, ...
    'StartFcn', @(hObj, event) timerStartFunction(hObject),...
    'StopFcn', @(hObj, event) timerStopFunction(hObject),...
    'ExecutionMode', 'fixedRate', ...
    'Period', period, 'TasksToExecute', 9.2233e+018, ...
    'BusyMode' , 'queue');

% save all variables in handles
handles.settings = settings;
handles.simulationObj = simulationObj;
handles.plotObj = plotObj;
handles.timerObj = timerObj;
handles.automateObj = automateObj;

dispAutomateStatus(handles);

% fill buttons with icons
set(handles.playButton, 'String', '');
jButton = java(findjobj(handles.playButton));

myIcon = fullfile('./icons/play.png');
jButton.setIcon(javax.swing.ImageIcon(myIcon));

set(handles.captureButton, 'String', '');
jButton = java(findjobj(handles.captureButton));

myIcon = fullfile('./icons/capture.png');
jButton.setIcon(javax.swing.ImageIcon(myIcon));

set(handles.resetButton, 'String', '');
jButton = java(findjobj(handles.resetButton));

myIcon = fullfile('./icons/rewind.png');
jButton.setIcon(javax.swing.ImageIcon(myIcon));

%set the tooltips
set(handles.playButton, 'TooltipString', 'Start the panic (p)');
set(handles.captureButton, 'TooltipString', 'Capture the panic as avi file (c)');
set(handles.resetButton, 'TooltipString', 'Reset (r)');

% Choose default command line output for PanicSimulatorGui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = PanicSimulatorGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
quitProcedure(handles);

% --- Stops the animation, deletes the timer object and closes the window.
function quitProcedure(handles)
% handles    structure with handles and user data (see GUIDATA)
stop(handles.timerObj);
delete(handles.timerObj);
delete(gcbf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% buttons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in playButton.
function playButton_Callback(hObject, eventdata, handles)
% hObject    handle to playButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if button is now pressed (get(hObject,'Value') == true) the animation 
% timer is started
playProcedure(handles);

% --- starts or stops timer
function playProcedure(handles)
% handles    structure with handles and user data (see GUIDATA)
buttonState = get(handles.playButton,'Value');
if buttonState
   start(handles.timerObj);
else    
   stop(handles.timerObj);
end


% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% resets agents in dependence of settings
handles = resetProcedure(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in captureButton.
function captureButton_Callback(hObject, eventdata, handles)
% hObject    handle to captureButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if button is pressed it creates a file with current time as file name
% and sets the variable captureBool to true
% if button is released it sets the variable captureBool to false
% and closes the video object
captureProcedure(handles);

% --- executes all necessary tasks for capturing the panic
function captureProcedure(handles)
hObject = handles.captureButton;
if ~get(hObject, 'Value')
    % make button grey    
    set(hObject, 'BackgroundColor', [240, 240, 240]/255);
    % change tooltip of capturing button
    set(hObject, 'TooltipString', 'Capture the panic as avi file (c)');
    handles.captureBool = false;
    guidata(hObject, handles);
    close(handles.videoObj); 
    % delete file if no frame has been recorded
    if get(handles.videoObj,'FrameCount') == 0
        delete([get(handles.videoObj,'Path'),'/',get(handles.videoObj, 'Filename')]);
        infoNoFramesCapturedGui();
    else
        filename = get(handles.videoObj, 'Filename');
        infoVideoFileSavedGui('filename', filename);
    end

else
    % if folder is not existent
    if (exist('videos', 'dir') ~= 7)
        set(hObject, 'Value', 0);
        if isdeployed
            videoFolderNotExistentExeGui();
        else
            videoFolderNotExistentMatGui();
        end
    else
        % make button red    
        set(hObject, 'BackgroundColor', [1, 0, 0]) 
        % change tooltip of capturing button
        set(hObject, 'TooltipString', 'Stop capturing (c)');
        % create avi-file
        fileName = ['videos/record_', datestr(now,'yyyy-mm-dd_HH-MM-SS'), '.avi'];
        handles.videoObj = VideoWriter(fileName);
        open(handles.videoObj);    
        handles.captureBool = true;    
        guidata(hObject, handles);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% other ui controls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function infoText_Callback(hObject, eventdata, handles)
% hObject    handle to infoText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of infoText as text
%        str2double(get(hObject,'String')) returns contents of infoText as a double


% --- Executes during object creation, after setting all properties.
function infoText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to infoText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% menu entries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------------------------------------------------------
function fileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to fileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function optionMenu_Callback(hObject, eventdata, handles)
% hObject    handle to optionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- deactivates all buttons in this GUI and calls settingsGui 
function settingsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to settingsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% deactivate all currently active ui controls
deactivationStruct = deactivateUiControls(handles.figure1);
% call settingsGui
[settings, resetBool] = settingsGui(handles.settings);
% change interval in which timer function is called
if settings.realTimeBool
    period = max(0.001,settings.dtPlot);
else
    period = 0.001;
end
set(handles.timerObj, 'Period', period);
handles.settings = settings;
%reset arena if necessary
if resetBool
    handles = resetProcedure(handles);
end
% make ui controls active again
reactivateUiControls(deactivationStruct);
% Update handles structure
guidata(hObject, handles);

% --- deactivates all buttons in this GUI and calls arena editor
function arenaEditorMenu_Callback(hObject, eventdata, handles)
% hObject    handle to arenaEditorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% deactivate all currently active ui controls
deactivationStruct = deactivateUiControls(handles.figure1);
% call editorGui
handles = arenaEditor(handles);

%replot arena
plotObj = handles.plotObj;
simulationObj = handles.simulationObj;
simulationObj.pressure = zeros(1,size(simulationObj.agents,1));
settings = handles.settings;

delete(plotObj.hCells);
delete(plotObj.hAgents(:));
delete(plotObj.hColumns(:));
delete(plotObj.hWallLines(:));

%plot everything
plotObj = plotInit(simulationObj, settings, handles.figure1);

% make ui controls active again
reactivateUiControls(deactivationStruct);

handles.plotObj = plotObj;
handles.simulationObj = simulationObj;

guidata(hObject, handles);

% --------------------------------------------------------------------
function quitMenu_Callback(hObject, eventdata, handles)
% hObject    handle to quitMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% calls the quit procedure
quitProcedure(handles);

% --- deactivates all buttons in this GUI and calls automateSettingsGui
function automateSettings_Callback(hObject, eventdata, handles)
% hObject    handle to automateSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% deactivate all currently active ui controls
deactivationStruct = deactivateUiControls(handles.figure1);
% call automate settings PanicSimulatorGui
[handles, resetBool] = automateSettingsGui(handles);
dispAutomateStatus(handles);

settings = handles.settings;
settings = modifySettingsDueToAutomateObj(handles.automateObj, settings);


handles.settings = settings;
if resetBool
    handles = resetProcedure(handles);
end

% make ui controls active again
reactivateUiControls(deactivationStruct);

guidata(hObject, handles);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% play/pause
if strcmp(eventdata.Key, 'p') && numel(eventdata.Modifier) == 0
    if strcmp(get(handles.playButton, 'enable'), 'on')
        set(handles.playButton,'Value', ~get(handles.playButton,'Value'));
        playProcedure(handles);
    end
% capture / stop capture
elseif strcmp(eventdata.Key, 'c') && numel(eventdata.Modifier) == 0
    if strcmp(get(handles.captureButton, 'enable'), 'on')
        set(handles.captureButton,'Value', ~get(handles.captureButton,'Value'));
        captureProcedure(handles);
    end
% reset arena
elseif strcmp(eventdata.Key, 'r') && numel(eventdata.Modifier) == 0
    if strcmp(get(handles.resetButton, 'enable'), 'on')
        resetProcedure(hObject, handles);
    end    
end




