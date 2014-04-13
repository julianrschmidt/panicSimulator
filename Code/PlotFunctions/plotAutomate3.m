function [automateObj3] = plotAutomate3( automateObj3 )
%PLOTAUTOMATE2 plots all individual exit times in addition to already
%   existing ones
if ishandle(automateObj3.hFig)
    figure(automateObj3.hFig);
else
    automateObj3.runN = 1;
    automateObj3.hFig = figure;
end
timesAgentsThroughDoor = automateObj3.timesAgentsThroughDoor;
hold on;
scatter(zeros(1,length(timesAgentsThroughDoor)) + automateObj3.runN, timesAgentsThroughDoor, 'xr');
hold off;
xlim([0, automateObj3.runN + 1]);
set(gca, 'XTick', 1:max(1,ceil(automateObj3.runN/20)):automateObj3.runN);
xlabel('simulation number');
ylabel('t [s]');
title('Time for each agent passing the exit');
automateObj3.runN = automateObj3.runN +1;
end