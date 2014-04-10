function agentButtonMoving( src, evnt )
%AGENTBUTTONMOVING moves current clicked agent's circle following mouse 
% movements
thisfig = gcf();
handles = guidata(thisfig);
% difference between current point and start point
xyDiff = get(gca,'CurrentPoint') - handles.temp.startpoint;
xyDiff = xyDiff(1,[1,2]);

% update x and y text fields
set(handles.xText, 'string', sprintf('%.2f', ...
    handles.simulationObj.agents(handles.currentAgentId, 1) + xyDiff(1)));
set(handles.yText, 'string', sprintf('%.2f', ...
    handles.simulationObj.agents(handles.currentAgentId, 2) + xyDiff(2)));

% calculate new position field of agent
newPos = handles.temp.oldPos + [xyDiff, 0, 0];
set(handles.temp.currentAgentHandle,'Position',newPos);

% Update handles structure
guidata(thisfig, handles);

end

