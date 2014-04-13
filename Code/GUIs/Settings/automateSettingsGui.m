function varargout = automateSettingsGui(varargin)
% AUTOMATESETTINGSGUI MATLAB code for automateSettingsGui.fig
%      settingsOut = AUTOMATESETTINGSGUI(handlesMain) creates a new AUTOMATESETTINGSGUI. 
%      The input handles is passed to automateSettingsGui_OpeningFcn via varargin.
%
% See also: GUIDE, GUIDATA, GUIHANDLES


% Last Modified by GUIDE v2.5 13-Apr-2014 19:19:14

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
handles.resetBool = false;
handles.possibleAutomatedVariableStrings = fieldnames(handles.automateObj.possibleAutomatedVariables);
aliasStrings = cell(1, length(handles.possibleAutomatedVariableStrings));
for i = 1:length(aliasStrings)
    aliasStrings{i} = handles.automateObj.possibleAutomatedVariables.(handles.possibleAutomatedVariableStrings{i}){1};
end
set(handles.variableToChangePopup, 'String', aliasStrings);
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
varargout{2} = handles.resetBool;

% The figure can be deleted now
delete(handles.figure1);


% --- Sets new settings as output and calls closing procedure
function okProcedure(hObject, handles)

handles.resetBool = true;
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
    'Load automate settings...', './presets/automateSettings.mat');
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
[filename, pathname, FilterIndex] = uiputfile('*.mat', 'Save automate settings as...', './presets/automateSettings.mat');
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

set(handles.individualExitTimesCheckbox, 'Value', 0);

set(handles.varStartEdit, 'enable', 'off');
set(handles.varEndEdit, 'enable', 'off');
set(handles.varStepEdit, 'enable', 'off');
set(handles.averageNEdit, 'enable', 'off');

set(handles.variableToChangePopup, 'Value', 1);
set(handles.varStartEdit, 'String', '-');
set(handles.varEndEdit, 'String', '-');
set(handles.varStepEdit, 'String', '-');
set(handles.averageNEdit, 'String', '-');

if automateObj.plotIndividualExitTimesBool
     set(handles.individualExitTimesCheckbox, 'Value', 1);
end

if ~strcmp(automateObj.activeAutomatedVariable, 'none')
    set(handles.varStartEdit, 'enable', 'on');
    set(handles.varEndEdit, 'enable', 'on');
    set(handles.varStepEdit, 'enable', 'on');
    set(handles.averageNEdit, 'enable', 'on');

    popupIndex = find(strcmp(handles.possibleAutomatedVariableStrings, ...
        automateObj.activeAutomatedVariable));
    set(handles.variableToChangePopup, 'Value', popupIndex);
    set(handles.varStartEdit, 'String', sprintf('%g', automateObj.variableRange(1)));
    set(handles.varEndEdit, 'String', sprintf('%g', automateObj.variableRange(end)));
    set(handles.varStepEdit, 'String', sprintf('%d', length(automateObj.variableRange)));
    set(handles.averageNEdit, 'String', sprintf('%d', automateObj.averageN));

    handles.lastValidEditValues.varStart = automateObj.variableRange(1);
    handles.lastValidEditValues.varEnd = automateObj.variableRange(end);
    handles.lastValidEditValues.varStep = length(automateObj.variableRange);
    handles.lastValidEditValues.averageN = automateObj.averageN;
end


% --- Executes on selection change in variableToChangePopup.
function variableToChangePopup_Callback(hObject, eventdata, handles)
% hObject    handle to variableToChangePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns variableToChangePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from variableToChangePopup
menueValue = get(hObject,'Value');
selectedAutomatedVariable = handles.possibleAutomatedVariableStrings{menueValue};
if strcmp(selectedAutomatedVariable, 'none')
    set(handles.varStartEdit, 'enable', 'off');
    set(handles.varEndEdit, 'enable', 'off');
    set(handles.varStepEdit, 'enable', 'off');
    set(handles.averageNEdit, 'enable', 'off');
else
    varStart = handles.automateObj.possibleAutomatedVariables.(selectedAutomatedVariable){3}(1);
    varEnd = handles.automateObj.possibleAutomatedVariables.(selectedAutomatedVariable){3}(2);
    varStep = handles.automateObj.possibleAutomatedVariables.(selectedAutomatedVariable){3}(3);
    averageN = 5;
    set(handles.varStartEdit, 'enable', 'on', 'String', num2str(varStart));
    set(handles.varEndEdit, 'enable', 'on', 'String',  num2str(varEnd));
    set(handles.varStepEdit, 'enable', 'on', 'String', varStep);
    set(handles.averageNEdit, 'enable', 'on', 'String', averageN);
    
    handles.automateObj.variableRange = varStart:varStep:varEnd;
    handles.automateObj.exitTimes = zeros(length(handles.automateObj.variableRange),1);
    handles.automateObj.averageN = averageN;
    
    handles.lastValidEditValues.varStart = varStart;
    handles.lastValidEditValues.varEnd = varEnd;
    handles.lastValidEditValues.varStep = varStep;
    handles.lastValidEditValues.averageN = averageN;
end
handles.automateObj.activeAutomatedVariable = selectedAutomatedVariable;
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

function varStartEdit_Callback(hObject, eventdata, handles)
% hObject    handle to varStartEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varStartEdit as text
%        str2double(get(hObject,'String')) returns contents of varStartEdit as a double
activeAutomatedVariable = handles.automateObj.activeAutomatedVariable;
intOrDoubleStr = handles.automateObj.possibleAutomatedVariables.(activeAutomatedVariable){5};
[varStart, sucess] = validateStr(get(hObject,'String'), intOrDoubleStr, ...
    handles.automateObj.possibleAutomatedVariables.(activeAutomatedVariable){2});

if sucess
    handles.lastValidEditValues.varStart = varStart;
else
    varStart = handles.lastValidEditValues.varStart;
    set(hObject,'String', sprintf('%g', varStart));
end
varEnd = handles.lastValidEditValues.varEnd;
varStep = handles.lastValidEditValues.varStep;
handles.automateObj.variableRange = varStart:varStep: varEnd;
handles.automateObj.exitTimes = zeros(varStep,1);
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
activeAutomatedVariable = handles.automateObj.activeAutomatedVariable;
intOrDoubleStr = handles.automateObj.possibleAutomatedVariables.(activeAutomatedVariable){5};

[varEnd, sucess] = validateStr(get(hObject,'String'), intOrDoubleStr, ...
    handles.automateObj.possibleAutomatedVariables.(activeAutomatedVariable){2});

if sucess
    handles.lastValidEditValues.varStart = varEnd;
else
    varEnd = handles.lastValidEditValues.varEnd;
    set(hObject,'String', sprintf('%g', varEnd));
end
varStart = handles.lastValidEditValues.varStart;
varStep = handles.lastValidEditValues.varStep;
handles.automateObj.variableRange = linspace(varStart, varEnd, varStep);
handles.automateObj.exitTimes = zeros(varStep,1);
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



function varStepEdit_Callback(hObject, eventdata, handles)
% hObject    handle to varStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varStepEdit as text
%        str2double(get(hObject,'String')) returns contents of varStepEdit as a double
activeAutomatedVariable = handles.automateObj.activeAutomatedVariable;
intOrDoubleStr = handles.automateObj.possibleAutomatedVariables.(activeAutomatedVariable){5};
[varStep, sucess] = validateStr(get(hObject,'String'), intOrDoubleStr, [eps,inf]);

if sucess
    handles.lastValidEditValues.varStep = varStep;
else
    varStep = handles.lastValidEditValues.varStep;
    set(hObject,'String', sprintf('%g', varStep));
end
varStart = handles.lastValidEditValues.varStart;
varEnd = handles.lastValidEditValues.varEnd;
handles.automateObj.variableRange = varStart:varStep:varEnd;
handles.automateObj.exitTimes = zeros(length(handles.automateObj.variableRange),1);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function varStepEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varStepEdit (see GCBO)
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
[averageN, sucess] = validateStr(get(hObject,'String'), 'int', [1,inf]);
if sucess
    handles.lastValidEditValues.averageN = averageN;
else
    averageN = handles.lastValidEditValues.averageN;
    set(hObject,'String', sprintf('%g', averageN));
end
handles.automateObj.averageN = averageN;
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


% --- Executes on button press in individualExitTimesCheckbox.
function individualExitTimesCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to individualExitTimesCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of individualExitTimesCheckbox
handles.automateObj.plotIndividualExitTimesBool = logical(get(hObject,'Value'));
guidata(hObject, handles);
