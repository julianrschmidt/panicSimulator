function varargout = PanicSimulator(varargin)
% PANICSIMULATOR MATLAB code for PanicSimulator.fig
%      PANICSIMULATOR, by itself, creates a new PANICSIMULATOR or raises the existing
%      singleton*.
%
%      H = PANICSIMULATOR returns the handle to a new PANICSIMULATOR or the handle to
%      the existing singleton*.
%
%      PANICSIMULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANICSIMULATOR.M with the given input arguments.
%
%      PANICSIMULATOR('Property','Value',...) creates a new PANICSIMULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the PANICSIMULATOR before PanicSimulator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PanicSimulator_OpeningFcn via varargin.
%
%      *See PANICSIMULATOR Options on GUIDE's Tools menu.  Choose "PANICSIMULATOR allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PanicSimulator

% Last Modified by GUIDE v2.5 12-Apr-2014 13:01:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PanicSimulator_OpeningFcn, ...
                   'gui_OutputFcn',  @PanicSimulator_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before PanicSimulator is made visible.
function PanicSimulator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PanicSimulator (see VARARGIN)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add code files to the search path:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('./Code'));

% load or generate settings
warningsOff();
if exist('presets/defaultSettings.mat', 'file') == 2
    if sum(strcmp(who('-file', 'presets/defaultSettings.mat'), 'settings')) == 1
        load('presets/defaultSettings.mat', 'settings');
        if checkSettings(settings)
        else
            settings = setInitCond();   
        end
    else
        settings = setInitCond();
    end
else
    settings = setInitCond();
end
% load or generate automate object
if exist('presets/defaultAutomateObj.mat', 'file') == 2
    if sum(strcmp(who('-file', 'presets/defaultAutoamteObj.mat'), 'automateObj')) == 1
        load('presets/defaultautomateObj.mat', 'automateObj');
        if checkAutomateObj(automateObj)
            settings = modifySettingsDueToAutomateObj(automateObj, settings);
        else
            automateObj = cell(1);
            automateObj{1} = [];
        end
    else
        automateObj = cell(1);
        automateObj{1} = [];
    end
else
    automateObj = cell(1);
    automateObj{1} = [];
end

% true if drawn images are captured
handles.captureBool = false;
%generate agents, walls  in dependence on settings
simulationObj = initArena(settings, cell(0));

%set time for simulation and plot
simulationObj = initSimulationObj(simulationObj);

%plot everything
plotObj = plotInit(simulationObj, settings, handles.figure1);

%create timerfunction for playing and stopping simulation
timerFcn = @(hObj, event) updateAndPlot(hObject);
if settings.realTimeBool
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

set(handles.playButton, 'TooltipString', 'Start the panic (p)');
set(handles.captureButton, 'TooltipString', 'Capture the panic (c)');
set(handles.resetButton, 'TooltipString', 'Reset (r)');

% Choose default command line output for PanicSimulator
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.

function varargout = PanicSimulator_OutputFcn(hObject, eventdata, handles) 
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

function quitProcedure(handles)
% handles    structure with handles and user data (see GUIDATA)
% stops the animation, deletes the timer and closes the window
stop(handles.timerObj);
delete(handles.timerObj);
delete(gcbf);


% --- Executes on button press in playButton.
function playButton_Callback(hObject, eventdata, handles)
% hObject    handle to playButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if button is now pressed (get(hObject,'Value') == true) the animation 
% timer is started
playProcedure(handles);

function playProcedure(handles)
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

function handles = resetProcedure(handles)
[handles.automateObj, handles.settings] = resetAutomateObj(handles.automateObj, handles.settings, 0);
dispAutomateStatus(handles);
set(handles.timeText, 'string', secondsToTimeString(0));

%generate agents, walls in dependence on settings
simulationObj = initArena(handles.settings, cell(0));

% from here everything similar to opening_fcn
simulationObj = initSimulationObj(simulationObj);

plotObj = handles.plotObj;
delete(plotObj.hCells);
delete(plotObj.hAgents(:));
delete(plotObj.hWalls(:));
delete(plotObj.hWallLines(:));
%plot everything
plotObj = plotInit(simulationObj, handles.settings, handles.figure1);
handles.simulationObj = simulationObj;
handles.plotObj = plotObj;


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

function captureProcedure(handles)
hObject = handles.captureButton;
if ~get(hObject, 'Value')
    % make button grey    
    set(hObject, 'BackgroundColor', [0.702, 0.702, 0.702]);
    set(hObject, 'TooltipString', 'Stop capturing (c)');
    handles.captureBool = false;
    guidata(hObject, handles);
    close(handles.videoObj); 
    if get(handles.videoObj,'FrameCount') == 0
        delete([get(handles.videoObj,'Path'),'/',get(handles.videoObj, 'Filename')]);
    end
else
    % make button red    
    set(hObject, 'BackgroundColor', [1, 0, 0]) 
    set(hObject, 'TooltipString', 'Capture the panic as avi (c)');
    fileName = ['videos/record_', datestr(now,'yyyy-mm-dd_HH-MM-SS'), '.avi'];
    handles.videoObj = VideoWriter(fileName);
    open(handles.videoObj);    
    handles.captureBool = true;    
    guidata(hObject, handles);
end

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


% --------------------------------------------------------------------
function settingsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to settingsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% pauses animation, calls settings PanicSimulator

% call settings PanicSimulator
hGuiObj = [findobj(allchild(handles.figure1), 'Type','uicontrol');...
    findobj(allchild(handles.figure1), 'Type','uimenu')];
enableStates = get(hGuiObj,'Enable');
set(hGuiObj,'Enable', 'off');
closeRequestFcnTemp = get(handles.figure1, 'CloseRequestFcn');
set(handles.figure1, 'CloseRequestFcn', '');
[settings, resetBool] = settingsGui(handles.settings);
if settings.realTimeBool
    period = max(0.001,settings.dtPlot);
else
    period = 0.001;
end
set(handles.timerObj, 'Period', period);
% make buttons active again
for guiObjNr = 1:length(hGuiObj)
    set(hGuiObj(guiObjNr),'Enable', enableStates{guiObjNr});
end
set(handles.figure1, 'CloseRequestFcn', closeRequestFcnTemp);
%reset field
handles.settings = settings;
if resetBool
    handles = resetProcedure(handles);
end
% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function arenaEditorMenu_Callback(hObject, eventdata, handles)
% hObject    handle to arenaEditorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% pauses animation and calls arena editor, redraws field after that

% call edit field PanicSimulator
hGuiObj = [findobj(allchild(handles.figure1), 'Type','uicontrol');...
    findobj(allchild(handles.figure1), 'Type','uimenu')];
enableStates = get(hGuiObj,'Enable');
set(hGuiObj,'Enable', 'off');
closeRequestFcnTemp = get(handles.figure1, 'CloseRequestFcn');
set(handles.figure1, 'CloseRequestFcn', '');
handles = arenaEditor(handles);
for guiObjNr = 1:length(hGuiObj)
    set(hGuiObj(guiObjNr),'Enable', enableStates{guiObjNr});
end
set(handles.figure1, 'CloseRequestFcn', closeRequestFcnTemp);

%replot arena
plotObj = handles.plotObj;
simulationObj = handles.simulationObj;
simulationObj.pressure = zeros(1,size(simulationObj.agents,1));
settings = handles.settings;

delete(plotObj.hCells);
delete(plotObj.hAgents(:));
delete(plotObj.hWalls(:));
delete(plotObj.hWallLines(:));

%plot everything
plotObj = plotInit(simulationObj, settings, handles.figure1);

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


% --------------------------------------------------------------------
function automateSettings_Callback(hObject, eventdata, handles)
% hObject    handle to automateSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call automate settings PanicSimulator
hGuiObj = [findobj(allchild(handles.figure1), 'Type','uicontrol');...
    findobj(allchild(handles.figure1), 'Type','uimenu')];
enableStates = get(hGuiObj,'Enable');
set(hGuiObj,'Enable', 'off');
closeRequestFcnTemp = get(handles.figure1, 'CloseRequestFcn');
set(handles.figure1, 'CloseRequestFcn', '');
handles = automateSettingsGui(handles);
dispAutomateStatus(handles);
for guiObjNr = 1:length(hGuiObj)
    set(hGuiObj(guiObjNr),'Enable', enableStates{guiObjNr});
end
set(handles.figure1, 'CloseRequestFcn', closeRequestFcnTemp);
settings = handles.settings;
settings = modifySettingsDueToAutomateObj(handles.automateObj, settings);


%redraw field
plotObj = handles.plotObj;
simulationObj = handles.simulationObj;


delete(plotObj.hCells);
delete(plotObj.hAgents(:));
delete(plotObj.hWalls(:));
delete(plotObj.hWallLines(:));

%plot everything
plotObj = plotInit(simulationObj, settings, handles.figure1);

handles.plotObj = plotObj;
handles.simulationObj = simulationObj;
handles.settings = settings;

guidata(hObject, handles);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'p') && numel(eventdata.Modifier) == 0
    if strcmp(get(handles.playButton, 'enable'), 'on')
        set(handles.playButton,'Value', ~get(handles.playButton,'Value'));
        playProcedure(handles);
    end
elseif strcmp(eventdata.Key, 'c') && numel(eventdata.Modifier) == 0
    if strcmp(get(handles.captureButton, 'enable'), 'on')
        set(handles.captureButton,'Value', ~get(handles.captureButton,'Value'));
        captureProcedure(handles);
    end
elseif strcmp(eventdata.Key, 'r') && numel(eventdata.Modifier) == 0
    if strcmp(get(handles.resetButton, 'enable'), 'on')
        resetProcedure(hObject, handles);
    end
    
end



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
