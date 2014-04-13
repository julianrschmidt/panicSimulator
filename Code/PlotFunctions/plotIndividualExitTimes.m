function [automateObj] = plotIndividualExitTimes( automateObj )
%PLOTAUTOMATE2 plots all individual exit times in addition to already
%   existing ones
hFig = automateObj.hFigIndividualExitTimes;
if ishandle(hFig)
    figure(hFig);
else
    automateObj.runN = 1;
    automateObj.hFigIndividualExitTimes = figure;
end
individualExitTimes = automateObj.individualExitTimes;
hold on;
scatter(zeros(1,length(individualExitTimes)) + automateObj.runN, individualExitTimes, 'xr');
hold off;
xlim([0, automateObj.runN + 1]);
set(gca, 'XTick', 1:max(1,ceil(automateObj.runN/20)):automateObj.runN);
xlabel('simulation number');
ylabel('t [s]');
title('Individual exit times');
automateObj.runN = automateObj.runN +1;
end