function plotUpdate( hObj,  agents, pressure)
%PLOTUPDATE updates the position of the agent circles and their pressure
% hObj - handle to all agent circles
% agents - agent matrix
for j = 1:length(hObj)
    r = agents(j,5);
    set(hObj(j), 'position', [agents(j,1) - r, agents(j,2) - r, 2*r, 2*r],...
        'FaceColor', colorMapPressure(pressure(j)));    
end
end

