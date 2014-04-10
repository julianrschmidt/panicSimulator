function agentButtonDown( src, evnt )
%AGENTBUTTONDOWN displays agent information on left click
%   enables moving agent when mouse is moved, deletes agent on right click

thisfig = gcbf();
handles = guidata(thisfig);
agents = handles.simulationObj.agents;
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click
% left click
if strcmp(clickStyle, 'normal')
    usrData = get(src, 'UserData');
    handles.currentAgentId = usrData(2);

    % enable all agent edit fields
    set(handles.agentRadiusEdit, 'enable', 'on');
    set(handles.agentVelocityEdit, 'enable', 'on');
    set(handles.agentDirectionEdit, 'enable', 'on');
    
    % fill all agent information fields with agent information
    set(handles.idText, 'string', sprintf('%d', handles.currentAgentId));
    set(handles.xText, 'string', sprintf('%.2f', agents(handles.currentAgentId, 1)));
    set(handles.yText, 'string', sprintf('%.2f', agents(handles.currentAgentId, 2)));
    
    % obtain all information about agent
    radius = agents(handles.currentAgentId, 5);
    vx = agents(handles.currentAgentId, 3);
    vy = agents(handles.currentAgentId, 4);
    v = sqrt(vx^2 + vy ^2); % absolute velocity
    angle = mod(atan2(vy, vx)*180/pi, 360); % angle in deg ccw to x-axis
    
    % fill all agent edit fields with agent information
    set(handles.agentRadiusEdit, 'string', sprintf('%.2f', radius));
    set(handles.agentVelocityEdit, 'string', sprintf('%.2f', v));
    set(handles.agentDirectionEdit, 'string', sprintf('%.2f', angle));  
    
    handles.lastValidEditValues.agentRadius = radius;
    handles.lastValidEditValues.agentVelocity = v;
    handles.lastValidEditValues.agentDirection = angle;
    
    % current coordinates of mouse in plot
    handles.temp.startpoint = get(gca,'CurrentPoint');        
    handles.temp.currentAgentHandle = src;
    % current position of agent
    handles.temp.oldPos = get(src, 'Position');
    % Update handles structure
    guidata(thisfig, handles);
    % set functions called when mouse is moved or the mouse button released
    set(thisfig,'WindowButtonMotionFcn',@agentButtonMoving);
    set(thisfig,'WindowButtonUpFcn',@agentButtonUp);
% right click
elseif strcmp(clickStyle, 'alt')
    
    usrData = get(src, 'UserData');
    currentAgentId = usrData(2);
    currentAgentHandle = src;
    % delete all traces of agent
    delete(currentAgentHandle);
    agents(currentAgentId,:) = [];    
    handles.plotObj.hAgents(currentAgentId) = [];
    for j = (currentAgentId):length(handles.plotObj.hAgents);
        set(handles.plotObj.hAgents(j), 'UserData', [1,j]);
    end
    handles.simulationObj.agents = agents;
    handles.currentAgentId = 0;
    guidata(thisfig, handles);
end

end

