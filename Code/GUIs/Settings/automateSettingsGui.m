function varargout = automateSettingsGui(varargin)
% AUTOMATESETTINGSGUI MATLAB code for automateSettingsGui.fig
%      settingsOut = AUTOMATESETTINGSGUI(handlesMain) creates a new AUTOMATESETTINGSGUI. 
%      The input handles is passed to automateSettingsGui_OpeningFcn via varargin.
%
% See also: GUIDE, GUIDATA, GUIHANDLES


% Last Modified by GUIDE v2.5 12-Apr-2014 18:22:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @automateSettingsGui_OpeningFcn, ...
                   'gui_OutputFcn',  @automateSettingsGui_OutputFcn, ...
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


% --- Executes just before automateSettingsGui is made visible.
function automateSettingsGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to automateSettingsGui (see VARARGIN)
handlesMain = varargin{1};
handles.settings = handlesMain.settings;
handles.automateObj = handlesMain.automateObj;
% store old settings, to be returned if user presses cancel button
handles.settingsOld = handles.settings;
handles.automateObjOld = handles.automateObj;

handles.handlesMain = handlesMain;
% fill all edit objects with the apropriate values
handles = fillEdits(hObject, handles);

% Choose default command line output for automateSettingsGui
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
function varargout = automateSettingsGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);

function handles = generateAutomateObj(hObject, handles)
popupNr = get(handles.variableToChangePopup, 'Value');
switch popupNr
    % none
    case 1
        automateObj = cell(1);
        automateObj{1} = [];
    % automatic change of velocity
    case 2
        automateObj = cell(1,2);
        automateObj{1} = 1;
        automateObj{2}.automateNr = 1;
        varStart = str2double(get(handles.varStartEdit, 'String'));
        varEnd = str2double(get(handles.varEndEdit, 'String'));
        varN = str2double(get(handles.varNEdit, 'String'));
        averageN = str2double(get(handles.averageNEdit, 'String'));
        automateObj{2}.vDesList = linspace(varStart,varEnd,varN);
        handles.settings.vDes = automateObj{2}.vDesList(1);
        automateObj{2}.vDesIndex = 1;
        automateObj{2}.averageIndex = 1;
        automateObj{2}.averageN = averageN;
        automateObj{2}.timeNeeded = zeros(1,length(automateObj{2}.vDesList));
    % automatic change of wall angle
    case 3
        automateObj = cell(1,2);
        automateObj{1} = 2;
        automateObj{2}.automateNr = 2;
        varStart = str2double(get(handles.varStartEdit, 'String'))*pi/180;
        varEnd = str2double(get(handles.varEndEdit, 'String'))*pi/180;
        varN = str2double(get(handles.varNEdit, 'String'));
        averageN = str2double(get(handles.averageNEdit, 'String'));
        automateObj{2}.wallAngleList = linspace(varStart,varEnd,varN);
        handles.settings = setWallAngle(handles.settings,automateObj{2}.wallAngleList(1));
        automateObj{2}.wallAngleIndex = 1;
        automateObj{2}.averageIndex = 1;
        automateObj{2}.averageN = averageN;
        automateObj{2}.timeNeeded = zeros(1,length(automateObj{2}.wallAngleList));
end

% plot individual exit times
if get(handles.automate3Checkbox, 'Value') == 1
        automateObj{1} = [automateObj{1}, 3];
        automateObj3 = createAutomateObj(3,handles.settings);
        automateObj = [automateObj, automateObj3{2}];
end
handles.automateObj = automateObj;


% --- Sets new settings as output and calls closing procedure
function okProcedure(hObject, handles)

handlesMain = handles.handlesMain;
handlesMain.settings = handles.settings;
handlesMain.automateObj = handles.automateObj;
handles.output = handlesMain;


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

handlesMain = handles.handlesMain;
handlesMain.settings = handles.settingsOld;
handlesMain.automateObj = handles.automateObjOld;
handles.output = handles.handlesMain;

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% menues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------------------------------------------------------
function openMenu_Callback(hObject, eventdata, handles)
% hObject    handle to openMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, pathName, filterIndex] = uigetfile('*.mat', ...
    'Load automate settings...', './presets/automateObj.mat');
if filterIndex ~= 0
    if sum(strcmp(who('-file', [pathName, fileName]), 'automateObj')) == 1
        load([pathName, fileName], 'automateObj');
        if validateAutomateObj(automateObj)
            handles.automateObj = automateObj;
            handles = fillEdits(hObject, handles);
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
automateObj = handles.automateObj;
[filename, pathname, FilterIndex] = uiputfile('*.mat', 'Save automate settings as...', './presets/automateObj.mat');
if (FilterIndex ~= 0)
    save([pathname, filename], 'automateObj');
end


% --------------------------------------------------------------------
function filesMenu_Callback(hObject, eventdata, handles)
% hObject    handle to filesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- fill all edit objects with the apropriate values
function handles = fillEdits(hObject, handles)
automateObj = handles.automateObj;

set(handles.automate3Checkbox, 'Value', 0);

set(handles.varStartEdit, 'enable', 'off');
set(handles.varEndEdit, 'enable', 'off');
set(handles.varNEdit, 'enable', 'off');
set(handles.averageNEdit, 'enable', 'off');

set(handles.variableToChangePopup, 'Value', 1);
set(handles.varStartEdit, 'String', '-');
set(handles.varEndEdit, 'String', '-');
set(handles.varNEdit, 'String', '-');
set(handles.averageNEdit, 'String', '-');

for index = 2:length(automateObj{1}) + 1
    automateNr = automateObj{index}.automateNr;
    switch automateNr
        % automatic change of velocity
        case 1
            set(handles.varStartEdit, 'enable', 'on');
            set(handles.varEndEdit, 'enable', 'on');
            set(handles.varNEdit, 'enable', 'on');
            set(handles.averageNEdit, 'enable', 'on');
            
            set(handles.variableToChangePopup, 'Value', 2);
            set(handles.varStartEdit, 'String', sprintf('%g', automateObj{index}.vDesList(1)));
            set(handles.varEndEdit, 'String', sprintf('%g', automateObj{index}.vDesList(end)));
            set(handles.varNEdit, 'String', sprintf('%d', length(automateObj{index}.vDesList)));
            set(handles.averageNEdit, 'String', sprintf('%d', automateObj{index}.averageN));
            
            handles.lastValidEditValues.varStart = automateObj{index}.vDesList(1);
            handles.lastValidEditValues.varEnd = automateObj{index}.vDesList(end);
            handles.lastValidEditValues.varN = length(automateObj{index}.vDesList);
            handles.lastValidEditValues.averageN = length(automateObj{index}.averageN);
        % automatic change of wall angle
        case 2
            set(handles.varStartEdit, 'enable', 'on');
            set(handles.varEndEdit, 'enable', 'on');
            set(handles.varNEdit, 'enable', 'on');
            set(handles.averageNEdit, 'enable', 'on');
            
            set(handles.variableToChangePopup, 'Value', 3);
            set(handles.varStartEdit, 'String', sprintf('%g', automateObj{index}.wallAngleList(1)*180/pi));
            set(handles.varEndEdit, 'String', sprintf('%g', automateObj{index}.wallAngleList(end)*180/pi));
            set(handles.varNEdit, 'String', sprintf('%.d', length(automateObj{index}.wallAngleList)));
            set(handles.averageNEdit, 'String', sprintf('%d', automateObj{index}.averageN));
            
            handles.lastValidEditValues.varStart = automateObj{index}.wallAngleList(1)*180/pi;
            handles.lastValidEditValues.varEnd = automateObj{index}.wallAngleList(end)*180/pi;
            handles.lastValidEditValues.varN = length(automateObj{index}.wallAngleList);
            handles.lastValidEditValues.averageN = length(automateObj{index}.averageN);
        % plot of individual exit times
        case 3
            set(handles.automate3Checkbox, 'Value', 1);
    end
end

% --- Executes on selection change in variableToChangePopup.
function variableToChangePopup_Callback(hObject, eventdata, handles)
% hObject    handle to variableToChangePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns variableToChangePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from variableToChangePopup
menueValue = get(hObject,'Value');
switch menueValue
    % none
    case 1
        set(handles.varStartEdit, 'enable', 'off');
        set(handles.varEndEdit, 'enable', 'off');
        set(handles.varNEdit, 'enable', 'off');
        set(handles.averageNEdit, 'enable', 'off');
    % velocity
    case 2
        set(handles.varStartEdit, 'enable', 'on', 'String', '1');
        set(handles.varEndEdit, 'enable', 'on', 'String', '6');
        set(handles.varNEdit, 'enable', 'on', 'String', '10');
        set(handles.averageNEdit, 'enable', 'on', 'String', '5');
        
        handles.lastValidEditValues.varStart = 1;
        handles.lastValidEditValues.varEnd = 6;
        handles.lastValidEditValues.varN = 10;
        handles.lastValidEditValues.averageN = 5;
    % wall angle
    case 3 
        set(handles.varStartEdit, 'enable', 'on', 'String', '0');
        set(handles.varEndEdit, 'enable', 'on', 'String', '90');
        set(handles.varNEdit, 'enable', 'on', 'String', '10');
        set(handles.averageNEdit, 'enable', 'on', 'String', '5');
        
        handles.lastValidEditValues.varStart = 0;
        handles.lastValidEditValues.varEnd = 90;
        handles.lastValidEditValues.varN = 10;
        handles.lastValidEditValues.averageN = 5;
            
end
handles = generateAutomateObj(hObject, handles);
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function variableToChangePopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variableToChangePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {'None', 'vDes', 'wallAngle'});

function varStartEdit_Callback(hObject, eventdata, handles)
% hObject    handle to varStartEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varStartEdit as text
%        str2double(get(hObject,'String')) returns contents of varStartEdit as a double
popupNr = get(handles.variableToChangePopup, 'Value');
switch popupNr
    case 2
        [num, sucess] = validateStr(get(hObject,'String'), 'double', [-inf,inf]);
    case 3
        [num, sucess] = validateStr(get(hObject,'String'), 'double', [0,90]);
end
if sucess
    handles.lastValidEditValues.varStart = num;
else
    num = handles.lastValidEditValues.varStart;
    set(hObject,'String', sprintf('%g', num));
end
handles = generateAutomateObj(hObject, handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function varStartEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varStartEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function varEndEdit_Callback(hObject, eventdata, handles)
% hObject    handle to varEndEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varEndEdit as text
%        str2double(get(hObject,'String')) returns contents of varEndEdit as a double
popupNr = get(handles.variableToChangePopup, 'Value');
switch popupNr
    case 2
        [num, sucess] = validateStr(get(hObject,'String'), 'double', [-inf,inf]);
    case 3
        [num, sucess] = validateStr(get(hObject,'String'), 'double', [0,90]);
end
if sucess
    handles.lastValidEditValues.varEnd = num;
else
    num = handles.lastValidEditValues.varEnd;
    set(hObject,'String', sprintf('%g', num));
end
handles = generateAutomateObj(hObject, handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function varEndEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varEndEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function varNEdit_Callback(hObject, eventdata, handles)
% hObject    handle to varNEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varNEdit as text
%        str2double(get(hObject,'String')) returns contents of varNEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'int', [1,inf]);
if sucess
    handles.lastValidEditValues.varN = num;
else
    num = handles.lastValidEditValues.varN;
    set(hObject,'String', sprintf('%g', num));
end
handles = generateAutomateObj(hObject, handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function varNEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varNEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function averageNEdit_Callback(hObject, eventdata, handles)
% hObject    handle to averageNEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of averageNEdit as text
%        str2double(get(hObject,'String')) returns contents of averageNEdit as a double
[num, sucess] = validateStr(get(hObject,'String'), 'int', [1,inf]);
if sucess
    handles.lastValidEditValues.averageN = num;
else
    num = handles.lastValidEditValues.averageN;
    set(hObject,'String', sprintf('%g', num));
end
handles = generateAutomateObj(hObject, handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function averageNEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to averageNEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in automate3Checkbox.
function automate3Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to automate3Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of automate3Checkbox
handles = generateAutomateObj(hObject, handles);
guidata(hObject, handles);
