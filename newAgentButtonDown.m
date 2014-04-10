function newAgentButtonDown( src, evnt )
%NEWAGENTBUTTONDOWN generates a new agent at current position of mouse
% with settings of edit fields
thisfig = gcf();
handles = guidata(thisfig);
clickStyle = get(gcbf, 'SelectionType'); % 'normal' for left and 
                                         % 'alt' for right click

if strcmp(clickStyle, 'normal')
    % figure out current coordinates of mouse
    currentPoint = get(gca,'CurrentPoint');    
    currentPoint = currentPoint(1,[1,2]);
    
    % determine new agent id
    currentAgentId = length(handles.plotObj.hAgents) + 1;
    % get all desired agent properties
    agentRadius = str2double(get(handles.agentRadiusEdit, 'String'));
    agentVelocity = str2double(get(handles.agentVelocityEdit, 'String'));
    agentAngle = str2double(get(handles.agentDirectionEdit, 'String'))...
        *2*pi/360;
    
    vx = agentVelocity*cos(agentAngle);
    vy = agentVelocity*sin(agentAngle);
   
    % store new agent
    newAgent = [currentPoint, vx, vy, agentRadius];
    handles.simulationObj.agents = [handles.simulationObj.agents; newAgent];
    
    % plot agent, save agent id and store agent handle
    hNewAgent = plotAgentCircle(newAgent(1), newAgent(2), newAgent(5));
    handles.plotObj.hAgents = [handles.plotObj.hAgents, hNewAgent];
    set(hNewAgent, 'UserData', [1,currentAgentId]);
    
                             
    % update the object information text
    set(handles.idText, 'string', sprintf('%d', currentAgentId));
    set(handles.xText, 'string', sprintf('%.2f', currentPoint(1)));
    set(handles.yText, 'string', sprintf('%.2f', currentPoint(2)));
    
    % Update handles structure
    guidata(thisfig, handles);
    
elseif strcmp(clickStyle, 'alt')

end

end



