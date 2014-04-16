function varargout = settingsGui(varargin)
% SETTINGSGUI MATLAB code for settingsGui.fig
%      settingsOut = SETTINGSGUI(settingsIn) creates a new SETTINGSGUI. 
%      The input handles is passed to settingsGui_OpeningFcn via varargin.
%      settingsIn will be returned modified as settingsOut
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified by GUIDE v2.5 16-Apr-2014 16:41:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @settingsGui_OpeningFcn, ...
                   'gui_OutputFcn',  @settingsGui_OutputFcn, ...
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


% --- Executes just before settingsGui is made visible.
function settingsGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to settingsGui (see VARARGIN)
handles.settings = varargin{1};
handles.resetBool = false;
% store old settings, to be returned if user presses cancel button
handles.settingsOld = handles.settings;
% fill all edit objects with the apropriate values
fillEdits(hObject, handles);

% Choose default command line output for settingsGui
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% store old settings as output
cancelProcedure(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = settingsGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.resetBool;

% The figure can be deleted now
delete(handles.figure1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Buttons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Sets new settings as output and calls closing procedure
function okProcedure(hObject, handles)
% store new settings as output

if handles.settings.xMaxCalcBool
    handles.settings = setXMax(handles.settings, calcXMax(handles.settings));
end

handles.output = handles.settings;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);

% --- Executes on button press in okButton.
function okButton_Callback(hObject, eventdata, handles)
% hObject    handle to okButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
okProcedure(hObject, handles);

% --- sets old settings parameters as output and calls closing procedure
function cancelProcedure(hObject, handles)
% store old settings as output
handles.output = handles.settingsOld;
handles.resetBool = false;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes on button press in cancelButton.
function cancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cancelProcedure(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fillEdits(hObject, handles)
% fill all edit objects with the apropriate values
set(handles.nAgentEdit, 'String', sprintf('%d', handles.settings.NAgent));
set(handles.doorWidthEdit, 'String', sprintf('%g', handles.settings.doorWidth));
set(handles.vDesEdit, 'String', sprintf('%g', handles.settings.vDes));
set(handles.densityEdit, 'String', sprintf('%g', handles.settings.density));
set(handles.AEdit, 'String', sprintf('%g', handles.settings.A));
set(handles.BEdit, 'String', sprintf('%g', handles.settings.B));
set(handles.kEdit, 'String', sprintf('%g', handles.settings.k));
set(handles.kappaEdit, 'String', sprintf('%g', handles.settings.kappa));
set(handles.tauEdit, 'String', sprintf('%g', handles.settings.tau));
set(handles.dtPlotEdit, 'String', sprintf('%g', handles.settings.dtPlot));
set(handles.wallAngleEdit, 'String', sprintf('%g', handles.settings.wallAngle));
set(handles.xMaxEdit, 'String', sprintf('%g', handles.settings.xMax));
set(handles.yMaxEdit, 'String', sprintf('%g', handles.settings.yMax));
set(handles.xMaxCheckbox, 'Value', double(handles.settings.xMaxCalcBool));
if handles.settings.xMaxCalcBool
    set(handles.xMaxEdit, 'Enable', 'Off');
else
    set(handles.xMaxEdit, 'Enable', 'On');
end
set(handles.pressureBoolCheckbox, 'Value', double(handles.settings.pressureBool));
set(handles.realTimeCheckbox, 'Value', double(handles.settings.realTimeBool));
if (strcmp(handles.settings.agentPositionStyle, 'randomLeftHalf'))
    set(handles.agentPositionStylePopup, 'Value', 1);
elseif (strcmp(handles.settings.agentPositionStyle, 'filename'))
    set(handles.agentPositionStylePopup, 'Value', 2);
end
    
if (strcmp(handles.settings.wallPositionStyle, 'standard'))
    set(handles.wallPositionStylePopup, 'Value', 1);
    set(handles.doorWidthEdit, 'Enable', 'On');
    set(handles.wallAngleEdit, 'Enable', 'On');
elseif (strcmp(handles.settings.wallPositionStyle, 'filename'))
    set(handles.wallPositionStylePopup, 'Value', 2);
    set(handles.doorWidthEdit, 'Enable', 'Off');
    set(handles.wallAngleEdit, 'Enable', 'Off');
end


function nAgentEdit_Callback(hObject, eventdata, handles)
% hObject    handle to nAgentEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nAgentEdit as text
%        str2double(get(hObject,'String')) returns contents of nAgentEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'int', [0,inf]);
if sucess
    handles.resetBool = true;
    handles.settings = setNAgent(handles.settings, num);
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%d', handles.settings.NAgent));
end


% --- Executes during object creation, after setting all properties.
function nAgentEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nAgentEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function doorWidthEdit_Callback(hObject, eventdata, handles)
% hObject    handle to doorWidthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of doorWidthEdit as text
%        str2double(get(hObject,'String')) returns contents of doorWidthEdit as a double
handles.resetBool = true;
[num, sucess] = validateStr(get(hObject,'String'), 'double', [0.01,inf]);
if sucess
    handles.settings.doorWidth = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.doorWidth));
end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function doorWidthEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to doorWidthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vDesEdit_Callback(hObject, eventdata, handles)
% hObject    handle to vDesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vDesEdit as text
%        str2double(get(hObject,'String')) returns contents of vDesEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [-inf,inf]);
if sucess
    handles.settings.vDes = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.vDes));
end

% --- Executes during object creation, after setting all properties.
function vDesEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vDesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function densityEdit_Callback(hObject, eventdata, handles)
% hObject    handle to densityEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of densityEdit as text
%        str2double(get(hObject,'String')) returns contents of densityEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [0.01,inf]);
if sucess
    handles.settings.density = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.density));
end

% --- Executes during object creation, after setting all properties.
function densityEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to densityEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AEdit_Callback(hObject, eventdata, handles)
% hObject    handle to AEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AEdit as text
%        str2double(get(hObject,'String')) returns contents of AEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [-inf,inf]);
if sucess
    handles.settings.A = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.A));
end

% --- Executes during object creation, after setting all properties.
function AEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BEdit_Callback(hObject, eventdata, handles)
% hObject    handle to BEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BEdit as text
%        str2double(get(hObject,'String')) returns contents of BEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [-inf,inf]);
if sucess
    handles.settings.B = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.B));
end

% --- Executes during object creation, after setting all properties.
function BEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kEdit_Callback(hObject, eventdata, handles)
% hObject    handle to kEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kEdit as text
%        str2double(get(hObject,'String')) returns contents of kEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [-inf,inf]);
if sucess
    handles.settings.k = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.k));
end

% --- Executes during object creation, after setting all properties.
function kEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kappaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to kappaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kappaEdit as text
%        str2double(get(hObject,'String')) returns contents of kappaEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [-inf,inf]);
if sucess
    handles.settings.kappa = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.kappa));
end

% --- Executes during object creation, after setting all properties.
function kappaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kappaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tauEdit_Callback(hObject, eventdata, handles)
% hObject    handle to tauEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tauEdit as text
%        str2double(get(hObject,'String')) returns contents of tauEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [0.001,inf]);
if sucess
    handles.settings.tau = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.tau));
end

% --- Executes during object creation, after setting all properties.
function tauEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tauEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dtPlotEdit_Callback(hObject, eventdata, handles)
% hObject    handle to dtPlotEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dtPlotEdit as text
%        str2double(get(hObject,'String')) returns contents of dtPlotEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [eps,inf]);
if sucess
    handles.settings.dtPlot = num;
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.dtPlot));
end

% --- Executes during object creation, after setting all properties.
function dtPlotEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dtPlotEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function wallAngleEdit_Callback(hObject, eventdata, handles)
% hObject    handle to wallAngleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[num, sucess] = validateStr(get(hObject,'String'), 'double', [0,90]);
if sucess
    handles.resetBool = true;
    handles.settings = setWallAngle(handles.settings, num);
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.wallAngle));
end

% --- Executes during object creation, after setting all properties.
function wallAngleEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wallAngleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function xMaxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to xMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xMaxEdit as text
%        str2double(get(hObject,'String')) returns contents of xMaxEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [2*handles.settings.border,inf]);
if sucess
    handles.resetBool = true;
    handles.settings = setXMax(handles.settings, num);
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.xMax));
end

% --- Executes during object creation, after setting all properties.
function xMaxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yMaxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to yMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yMaxEdit as text
%        str2double(get(hObject,'String')) returns contents of yMaxEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'double', [handles.settings.border+0.4,inf]);
if sucess
    handles.resetBool = true;
    handles.settings = setYMax(handles.settings, num);
    % Update handles structure
    guidata(hObject, handles);
else 
    set(hObject,'String', sprintf('%g', handles.settings.yMax));
end

% --- Executes during object creation, after setting all properties.
function yMaxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in xMaxCheckbox.
function xMaxCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to xMaxCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of xMaxCheckbox
if logical(get(hObject,'Value'))    
    set(handles.xMaxEdit, 'Enable', 'Off');
    handles.settings.xMaxCalcBool = true;
else
    set(handles.xMaxEdit, 'Enable', 'On');
    handles.settings.xMaxCalcBool = false;
end
    
guidata(hObject, handles);


% --- Executes on button press in pressureBoolCheckbox.
function pressureBoolCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to pressureBoolCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pressureBoolCheckbox
handles.settings.pressureBool = logical(get(hObject,'Value'));
guidata(hObject, handles);


% --- Executes on selection change in agentPositionStylePopup.
function agentPositionStylePopup_Callback(hObject, eventdata, handles)
% hObject    handle to agentPositionStylePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns agentPositionStylePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from agentPositionStylePopup
handles.resetBool = true;
menueValue = get(hObject,'Value');
if menueValue == 1
    handles.settings.agentPositionStyle = 'randomLeftHalf';
elseif menueValue == 2
    [fileName, pathName, filterIndex] = uigetfile('*.mat', 'Open Agents...', './presets/agents.mat');
    if filterIndex ~= 0
        handles.settings.agentPositionStyle = 'filename';
        handles.settings.agentPositionFilename = [pathName, fileName];
    else
        if strcmp(handles.settings.agentPositionStyle, 'randomLeftHalf')
            set(hObject, 'Value', 1);
        elseif strcmp(handles.settings.agentPositionStyle, 'filename')
            set(hObject, 'Value', 2);
        end
    end
end
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function agentPositionStylePopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to agentPositionStylePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {'Random', 'From File...'});


% --- Executes on selection change in wallPositionStylePopup.
function wallPositionStylePopup_Callback(hObject, eventdata, handles)
% hObject    handle to wallPositionStylePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wallPositionStylePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wallPositionStylePopup
handles.resetBool = true;
menueValue = get(hObject,'Value');
if menueValue == 1
    handles.settings.wallPositionStyle = 'standard';
    set(handles.doorWidthEdit, 'Enable', 'On');
    set(handles.wallAngleEdit, 'Enable', 'On');
elseif menueValue == 2
    [fileName, pathName, filterIndex] = uigetfile('*.mat', 'Define Wall file...', './presets/walls.mat');
    if filterIndex ~= 0
        handles.settings.wallPositionStyle = 'filename';
        handles.settings.wallPositionFilename = [pathName, fileName];
        set(handles.doorWidthEdit, 'Enable', 'Off');
        set(handles.wallAngleEdit, 'Enable', 'Off');
    else
        if strcmp(handles.settings.wallPositionStyle, 'standard')
            set(hObject, 'Value', 1);
            set(handles.doorWidthEdit, 'Enable', 'On');
            set(handles.wallAngleEdit, 'Enable', 'On');
        elseif strcmp(handles.settings.wallPositionStyle, 'filename')
            set(hObject, 'Value', 2);
            set(handles.doorWidthEdit, 'Enable', 'Off');
            set(handles.wallAngleEdit, 'Enable', 'Off');
        end
    end
end
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function wallPositionStylePopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wallPositionStylePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {'Standard', 'From File...'});


% --------------------------------------------------------------------
function openMenu_Callback(hObject, eventdata, handles)
% hObject    handle to openMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, pathName, filterIndex] = uigetfile('*.mat', ...
    'Load settings...', './presets/settings.mat');
if filterIndex ~= 0
    if sum(strcmp(who('-file', [pathName, fileName]), 'settings')) == 1
        load([pathName, fileName], 'settings');
        if validateSettings(settings)
            handles.settings = settings;
            fillEdits(hObject, handles);
            guidata(hObject, handles);
        else
            errorOpenFileGui('filename',[pathName, fileName]);
        end
    else
        errorOpenFileGui('filename',[pathName, fileName]);
    end
end

% --------------------------------------------------------------------
function saveAsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to saveAsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
settings = handles.settings;
[filename, pathname, FilterIndex] = uiputfile('*.mat', 'Save settings as...', './presets/settings.mat');
if (FilterIndex ~= 0)
    save([pathname, filename], 'settings');
end


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key, 'escape')
    cancelProcedure(hObject, handles);
elseif strcmp(eventdata.Key, 'return')
    okProcedure(hObject, handles);
end


% --------------------------------------------------------------------
function filesMenu_Callback(hObject, eventdata, handles)
% hObject    handle to filesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in realTimeCheckbox.
function realTimeCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to realTimeCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of realTimeCheckbox
handles.settings.realTimeBool = logical(get(hObject, 'Value'));
guidata(hObject, handles);
