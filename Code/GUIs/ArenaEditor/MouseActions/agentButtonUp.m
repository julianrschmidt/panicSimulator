function agentButtonUp( src, evnt )
%AGENTBUTTONUP saves new agent coordinates of moved agent
thisfig = gcf();
% delete functions earlier called when mouse was moved or button released
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
handles = guidata(thisfig);

% difference between current point and start point
xyDiff = get(gca,'CurrentPoint') - handles.temp.startpoint;
xyDiff = xyDiff(1,[1,2]);

% update agent data
agents = handles.simulationObj.agents;
agents(handles.currentAgentId,[1 2]) = ...
    agents(handles.currentAgentId,[1 2]) + xyDiff;
handles.simulationObj.agents = agents;

% update x and y text fields
set(handles.xText, 'string', sprintf('%.2f', ...
    handles.simulationObj.agents(handles.currentAgentId, 1)));
set(handles.yText, 'string', sprintf('%.2f', ...
    handles.simulationObj.agents(handles.currentAgentId, 2)));

% delete temporary field 'temp' in handles
handles = rmfield(handles, 'temp');

% Update handles structure
guidata(thisfig, handles);
end

