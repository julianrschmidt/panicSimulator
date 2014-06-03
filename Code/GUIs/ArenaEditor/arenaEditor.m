function varargout = arenaEditor(varargin)
% ARENAEDITOR MATLAB code for arenaEditor.fig
%     
%
%      h = ARENAEDITOR(handles) creates a new ARENAEDITOR. handles must 
%       be a cell array, containing at least the following variables
% 
%      settings
%      simulationObj
%
%      The input is passed to arenaEditor_OpeningFcn via varargin.
%      handles will be returned in the output variable h as it was, apart 
%      from the following variables which could have been changed:
% 
%      agents
%      columns
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES


% Last Modified by GUIDE v2.5 14-Apr-2014 17:29:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @arenaEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @arenaEditor_OutputFcn, ...
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


% --- Executes just before arenaEditor is made visible.
function arenaEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to arenaEditor (see VARARGIN)
handlesMain = varargin{1};
settings = handlesMain.settings;
handles = fillEdits(hObject, handles);
simulationObj = handlesMain.simulationObj;

% plot everything
plotObj = plotInit(simulationObj, settings, handles.figure1);

% save hObject in Userdata in the axes
% guidata(get(gca, 'UserData')) returns handles
set(handles.axes1, 'UserData', hObject);

% set buttonDown functions to objects
hAgents = plotObj.hAgents;
hColumns = plotObj.hColumns;
hWallLines = plotObj.hWallLines;
hExit = plotObj.hExit;
set([hAgents(:); hColumns(:); hWallLines(:); hExit(:)],'ButtonDownFcn', @objectButtonDown);   

% initialize some variables
handles.currentAgentId = 0;
handles.currentWallId = 0;
handles.currentWallLineId = 0;
handles.settings = settings;
handles.simulationObj = simulationObj;
handles.plotObj = plotObj;
handles.handlesMain = handlesMain;
handles.oldTool = 'modifyObjectTool';
handles.hAllTools = findobj('-regexp','Tag','[a-z]+Tool','-not','Tag','PreviewTool');

% Choose default command line output for arenaEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = arenaEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);

% --- fill all edit objects with the apropriate values
function handles = fillEdits(hObject, handles)
set(handles.agentRadiusEdit, 'String', sprintf('%g', 0.3));
set(handles.agentVelocityEdit, 'String', sprintf('%g', 1));
set(handles.agentDirectionEdit, 'String', sprintf('%g', 0));
set(handles.wallRadiusEdit, 'String', sprintf('%g', 0.5))

lastValidEditValues.agentRadius = 0.3;
lastValidEditValues.agentVelocity = 1;
lastValidEditValues.agentDirection = 0;
lastValidEditValues.wallRadius = 0.5;
handles.lastValidEditValues = lastValidEditValues;

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cancelProcedure(hObject, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% buttons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in okButton.
function okButton_Callback(hObject, eventdata, handles)
% hObject    handle to okButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.

okProcedure(hObject, handles);

% --- sets new handles parameters as output and calls closing procedure
function okProcedure(hObject, handles)
% prepare output varible
handlesMain = handles.handlesMain;
handlesMain.simulationObj = handles.simulationObj;
handles.output = handlesMain;
guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in cancelButton.
function cancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% stores unmodified handles variable in output
cancelProcedure(hObject, handles);

% --- sets old handles parameters as output and calls closing procedure
function cancelProcedure(hObject, handles)
handlesMain = handles.handlesMain;
handles.output = handlesMain;
guidata(hObject, handles);
uiresume(handles.figure1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% menues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --------------------------------------------------------------------
function fileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to fileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveAgentsAsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to saveAgentsAsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
agents = handles.simulationObj.agents;
[filename, pathname, FilterIndex] = uiputfile('*.mat', 'Save agents as...', './presets/agents.mat');
if (FilterIndex ~= 0)
    save([pathname, filename], 'agents');
end

% --------------------------------------------------------------------
function saveWallsAsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to saveWallsAsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
columns = handles.simulationObj.columns;
wallLines = handles.simulationObj.wallLines;
exitCoord = handles.simulationObj.exitCoord;
[filename, pathname, FilterIndex] = uiputfile('*.mat', 'Save walls as...', './presets/walls.mat');
if (FilterIndex ~= 0)
    save([pathname, filename], 'columns', 'wallLines', 'exitCoord');
end

% --------------------------------------------------------------------
function openAgentsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to openAgentsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, pathName, filterIndex] = uigetfile('*.mat', 'Load Agents...', './presets/agents.mat');
if filterIndex ~= 0
    if sum(strcmp(who('-file', [pathName, fileName]), 'agents')) == 1
        load([pathName, fileName], 'agents');
        if validateAgents(agents)
            handles.simulationObj.agents = agents;
            delete(handles.plotObj.hAgents);
            hAgents = zeros(1, size(agents, 1));
            for j = 1:length(hAgents) 
                hAgents(j) = plotAgentCircle(agents(j,1), agents(j,2), agents(j,5));
                set(hAgents(j), 'UserData', [1,j]);
            end
            if strcmp(handles.oldTool, 'modifyObjectTool')
                set(hAgents(:),'ButtonDownFcn', @objectButtonDown);   
            end
            handles.plotObj.hAgents = hAgents;
            guidata(hObject, handles);
        else
            errorOpenFileGui('filename',[pathName, fileName]);
        end
    else
        errorOpenFileGui('filename',[pathName, fileName]);
    end
end


% --------------------------------------------------------------------
function openWallsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to openWallsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, pathName, filterIndex] = uigetfile('*.mat', 'Load walls...', './presets/walls.mat');
if filterIndex ~= 0
    if sum(strcmp(who('-file', [pathName, fileName]), 'columns')) == 1 && ...
            sum(strcmp(who('-file', [pathName, fileName]), 'wallLines')) == 1 && ...
            sum(strcmp(who('-file', [pathName, fileName]), 'exitCoord')) == 1
        load([pathName, fileName], 'columns', 'wallLines', 'exitCoord');
        if validateColumns(columns) && validateWallLines(wallLines) &&validateExitCoord(exitCoord)
            handles.simulationObj.columns = columns;
            handles.simulationObj.wallLines = wallLines;
            handles.simulationObj.exitCoord = exitCoord;
            delete(handles.plotObj.hColumns);
            delete(handles.plotObj.hWallLines);
            delete(handles.plotObj.hExit);
            hColumns = zeros(1, size(columns, 1));
            for j = 1:length(hColumns) 
                hColumns(j) = plotWallColumn(columns(j,1), columns(j,2), columns(j,3));
                set(hColumns(j), 'UserData', [2,j]);
            end
            handles.plotObj.hColumns = hColumns;
            NWallLines = size(wallLines, 1);
            hWallLines = zeros(1, NWallLines);
            for j = 1:NWallLines
                hWallLines(j) = plotWallLine([wallLines(j,1), wallLines(j,3)], [wallLines(j,2), wallLines(j,4)]);
                set(hWallLines(j), 'UserData', [3,j]);
            end

            handles.plotObj.hWallLines = hWallLines;

            hExit = plotExitLine([exitCoord(1), exitCoord(3)], [exitCoord(2), exitCoord(4)]);
            set(hExit(1), 'UserData', [4, hExit(2)]);
            set(hExit(2), 'UserData', [4, hExit(1)]);
            
            if strcmp(handles.oldTool, 'modifyObjectTool')
                set([hColumns(:); hWallLines(:); hExit(:)],'ButtonDownFcn', @objectButtonDown);   
            end

            guidata(hObject, handles);
        else
            errorOpenFileGui('filename',[pathName, fileName]);
        end
    else
        errorOpenFileGui('filename',[pathName, fileName]);
    end
end


% --------------------------------------------------------------------
function editMenu_Callback(hObject, eventdata, handles)
% hObject    handle to editMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function clearAgentsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to clearAgentsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
agents = [];
handles.simulationObj.agents = agents;
delete(handles.plotObj.hAgents);
handles.plotObj.hAgents = [];
guidata(hObject, handles);


% --------------------------------------------------------------------
function clearWallsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to clearWallsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
columns = [];
handles.simulationObj.columns = columns;
delete(handles.plotObj.hColumns);
handles.plotObj.hColumns = [];
handles.simulationObj.wallLines = [];
delete(handles.plotObj.hWallLines);
handles.plotObj.hWallLines = [];
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% edit fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function agentRadiusEdit_Callback(hObject, eventdata, handles)
% hObject    handle to agentRadiusEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%sets the typed in number as the current radius of the clicked agent if any
[num, sucess] = validateStr(get(hObject,'String'), 'double', [eps,inf]);
if sucess
    handles.lastValidEditValues.agentRadius = num;
    guidata(hObject, handles);
else
    num = handles.lastValidEditValues.agentRadius;
    set(hObject,'String', sprintf('%g', num));
end
currentAgentId = handles.currentAgentId;
if currentAgentId ~= 0
    agents = handles.simulationObj.agents;
    radius = num;
    agents(currentAgentId, 5) = radius;
    hAgent = handles.plotObj.hAgents(currentAgentId);
    x = agents(currentAgentId, 1);
    y = agents(currentAgentId, 2);
    set(hAgent, 'Position', [x-radius, y-radius, 2*radius, 2*radius]);
    handles.simulationObj.agents = agents;
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function agentRadiusEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to agentRadiusEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function agentVelocityEdit_Callback(hObject, eventdata, handles)
% hObject    handle to agentVelocityEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% sets the typed in number as the current velocity of the clicked agent if 
% any
[num, sucess] = validateStr(get(hObject,'String'), 'double', [0,inf]);
if sucess
    handles.lastValidEditValues.agentVelocity = num;
    guidata(hObject, handles);
else
    num = handles.lastValidEditValues.agentVelocity;
    set(hObject,'String', sprintf('%g', num));
end
currentAgentId = handles.currentAgentId;
if currentAgentId ~= 0
    velocity = num;
    angle = str2double(get(handles.agentDirectionEdit,'String'))*2*pi/360;
    
    handles.simulationObj.agents(currentAgentId, 3) = velocity*cos(angle);
    handles.simulationObj.agents(currentAgentId, 4) = velocity*sin(angle);
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function agentVelocityEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to agentVelocityEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function agentDirectionEdit_Callback(hObject, eventdata, handles)
% hObject    handle to agentDirectionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% sets the typed in number as the current angle of direction 
% of the clicked agent if any

[num, sucess] = validateStr(get(hObject,'String'), 'double', [0,360]);
if sucess
    handles.lastValidEditValues.agentDirection = num;
    guidata(hObject, handles);
else
    num = handles.lastValidEditValues.agentDirection;
    set(hObject,'String', sprintf('%g',num));
end

currentAgentId = handles.currentAgentId;
if currentAgentId ~= 0
    velocity = str2double(get(handles.agentVelocityEdit,'String'));
    angle = str2double(get(hObject,'String'))*pi/180;
    
    handles.simulationObj.agents(currentAgentId, 3) = velocity*cos(angle);
    handles.simulationObj.agents(currentAgentId, 4) = velocity*sin(angle);
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function agentDirectionEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to agentDirectionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function wallRadiusEdit_Callback(hObject, eventdata, handles)
% hObject    handle to wallRadiusEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%sets the typed in number as the current radius of the clicked wall if any
[num, sucess] = validateStr(get(hObject,'String'), 'double', [0,inf]);
if sucess
    handles.lastValidEditValues.wallRadius = num;
    guidata(hObject, handles);
else
    num = handles.lastValidEditValues.wallRadius;
    set(hObject,'String', sprintf('%g',num));
end
currentWallId = handles.currentWallId;
if currentWallId ~= 0
    columns = handles.simulationObj.columns;
    radius = num;
    columns(currentWallId, 3) = radius;
    hWall = handles.plotObj.hColumns(currentWallId);   
    x = columns(currentWallId, 1);
    y = columns(currentWallId, 2);
    set(hWall, 'Position', [x-radius, y-radius, 2*radius, 2*radius]);
    handles.simulationObj.columns = columns;
    guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function wallRadiusEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wallRadiusEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tools
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------------------------------------------------------
function toolChosen_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to modifyObjectTool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(hObject,'State'), 'on'))
    allOtherToolsOff(hObject, handles);
    changeTool(hObject, handles, get(hObject,'Tag'));
else
    set(hObject, 'State', 'on');
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
elseif strcmp(eventdata.Key, 'delete')
    currentAgentId = handles.currentAgentId;
    currentWallId = handles.currentWallId;
    currentWallLineId = handles.currentWallLineId;
    if currentAgentId ~= 0   
        agents = handles.simulationObj.agents;
        currentAgentHandle = handles.plotObj.hAgents(currentAgentId);
        % delete all traces of agent
        delete(currentAgentHandle);
        agents(currentAgentId,:) = [];    
        handles.plotObj.hAgents(currentAgentId) = [];
        for j = (currentAgentId):length(handles.plotObj.hAgents);
            set(handles.plotObj.hAgents(j), 'UserData', [1,j]);
        end
        handles.simulationObj.agents = agents;
        handles.currentAgentId = 0;
        guidata(hObject, handles);
    elseif currentWallId ~= 0
        columns = handles.simulationObj.columns;
        currentWallHandle = handles.plotObj.hColumns(currentWallId);
        % delete all traces of wall
        delete(currentWallHandle);
        columns(currentWallId,:) = [];    
        handles.plotObj.hColumns(currentWallId) = [];
        for j = (currentWallId):length(handles.plotObj.hColumns);
            set(handles.plotObj.hColumns(j), 'UserData', [2,j]);
        end
        handles.currentWallId = 0;
        handles.simulationObj.columns = columns;
        % Update handles structure
        guidata(hObject, handles);
    elseif currentWallLineId ~= 0;
        wallLines = handles.simulationObj.wallLines;
        currentWallLineHandle = handles.plotObj.hWallLines(currentWallLineId);
        % delete all traces of wall line
        delete(currentWallLineHandle);
        wallLines(currentWallLineId,:) = [];    
        handles.plotObj.hWallLines(currentWallLineId) = [];
        for j = (currentWallLineId):length(handles.plotObj.hWallLines);
            set(handles.plotObj.hWallLines(j), 'UserData', [3,j]);
        end
        handles.simulationObj.wallLines = wallLines;
        handles.currentWallLineId = 0;
        guidata(hObject, handles);
    end
elseif strcmp(eventdata.Key, 'v') && numel(eventdata.Modifier) == 0
    hTool = findobj('Tag','modifyObjectTool');
    set(hTool,'State', 'on');
    toolChosen_ClickedCallback(hTool, [], handles);
elseif strcmp(eventdata.Key, 'a') && numel(eventdata.Modifier) == 0
    hTool = findobj('Tag','newAgentTool');
    set(hTool,'State', 'on');
    toolChosen_ClickedCallback(hTool, [], handles);
elseif strcmp(eventdata.Key, 'w') && numel(eventdata.Modifier) == 0
    hTool = findobj('Tag','newWallTool');
    set(hTool,'State', 'on');
    toolChosen_ClickedCallback(hTool, [], handles);
elseif strcmp(eventdata.Key, 'c') && numel(eventdata.Modifier) == 0
    hTool = findobj('Tag','newColumnTool');
    set(hTool,'State', 'on');
    toolChosen_ClickedCallback(hTool, [], handles);
elseif strcmp(eventdata.Key, 'l') && numel(eventdata.Modifier) == 0
    hTool = findobj('Tag','lineOfColumnsTool');
    set(hTool,'State', 'on');
    toolChosen_ClickedCallback(hTool, [], handles);
elseif strcmp(eventdata.Key, 'o') && numel(eventdata.Modifier) == 0
    hTool = findobj('Tag','circleOfColumnsTool');
    set(hTool,'State', 'on');
    toolChosen_ClickedCallback(hTool, [], handles);
elseif strcmp(eventdata.Key, 'x') && numel(eventdata.Modifier) == 0
    hTool = findobj('Tag','newExitTool');
    set(hTool,'State', 'on');
    toolChosen_ClickedCallback(hTool, [], handles);
end

function changeTool(hObject, handles, newTool)
oldTool = handles.oldTool;
% tidy up the mess from before
switch oldTool     
    case 'newAgentTool'
        hCells = handles.plotObj.hCells;
        set(hCells, 'ButtonDownFcn', '');      
    case 'newColumnTool'
        hCells = handles.plotObj.hCells;
        set(hCells, 'ButtonDownFcn', '');        
    case 'lineOfColumnsTool'
        hCells = handles.plotObj.hCells;
        set(hCells, 'ButtonDownFcn', '');
    case 'circleOfColumnsTool'
        hCells = handles.plotObj.hCells;
        set(hCells, 'ButtonDownFcn', '');
    case 'newWallTool'
        hCells = handles.plotObj.hCells;
        set(hCells, 'ButtonDownFcn', ''); 
    case 'newExitTool'
        hCells = handles.plotObj.hCells;
        set(hCells, 'ButtonDownFcn', ''); 
    case 'modifyObjectTool'
        hAgents = handles.plotObj.hAgents;
        hColumns = handles.plotObj.hColumns;
        hWallLines = handles.plotObj.hWallLines;
        hExit = handles.plotObj.hExit;
        set([hAgents(:); hColumns(:); hWallLines(:); hExit(:)],'ButtonDownFcn',''); 
end
% some general tidying up
set(handles.infoText, 'String', ...
            '');
set(handles.agentRadiusEdit, 'enable', 'off');
set(handles.agentVelocityEdit, 'enable', 'off');
set(handles.agentDirectionEdit, 'enable', 'off');
set(handles.wallRadiusEdit, 'enable', 'off');
set(handles.idText, 'string', sprintf('-'));
set(handles.xText, 'string', sprintf('-'));
set(handles.yText, 'string', sprintf('-'));
handles.currentAgentId = 0;
handles.currentWallId = 0;
handles.currentWallLineId = 0;

% set callbacks for different tools and enable certain edit fields
switch newTool
    case 'newAgentTool'
        set(handles.infoText, 'String', ...
            '   Click to place new agent.');
        set(handles.agentRadiusEdit, 'enable', 'on');
        set(handles.agentVelocityEdit, 'enable', 'on');
        set(handles.agentDirectionEdit, 'enable', 'on');
        
        hCells = handles.plotObj.hCells;
        set(hCells, 'ButtonDownFcn', @newAgentButtonDown);     
    case 'newColumnTool'        
        set(handles.infoText, 'String', ...
            '   Click to place new column.');
        set(handles.wallRadiusEdit, 'enable', 'on');
        
        hCells = handles.plotObj.hCells;
        set(hCells, 'ButtonDownFcn', @newColumnButtonDown);        
    case 'lineOfColumnsTool'
        set(handles.infoText, 'String', ...
            '   Click and drag to draw new line of columns.');
        set(handles.wallRadiusEdit, 'enable', 'on');
        
        hCells = handles.plotObj.hCells;    
        set(hCells, 'ButtonDownFcn', @lineOfColumnsButtonDown);
    case 'circleOfColumnsTool'
        set(handles.infoText, 'String', ...
            '   Click and drag to draw new circle of columns.');
        set(handles.wallRadiusEdit, 'enable', 'on');        
        hCells = handles.plotObj.hCells;    
        set(hCells, 'ButtonDownFcn', @circleOfColumnsButtonDown);
    case 'newWallTool'   
        set(handles.infoText, 'String', ...
            '   Click and drag to draw new wall.');
        hCells = handles.plotObj.hCells;    
        set(hCells, 'ButtonDownFcn', @newWallLineButtonDown);
    case 'newExitTool'   
        set(handles.infoText, 'String', ...
            '   Click and drag to draw new exit line.');
        hCells = handles.plotObj.hCells;    
        set(hCells, 'ButtonDownFcn', @newExitLineButtonDown);
    case 'modifyObjectTool'        
        set(handles.infoText, 'String', ...
            '   Left click: move object   Right click: delete object');
        hAgents = handles.plotObj.hAgents;
        hColumns = handles.plotObj.hColumns;
        hWallLines = handles.plotObj.hWallLines;
        hExit = handles.plotObj.hExit;
        set([hAgents(:); hColumns(:); hWallLines(:); hExit(:)],'ButtonDownFcn', @objectButtonDown);   
end
handles.oldTool = newTool;
guidata(hObject, handles);

function allOtherToolsOff(hObject,handles)
set(handles.hAllTools, 'State', 'off');
set(hObject, 'State', 'on');
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% other ui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


