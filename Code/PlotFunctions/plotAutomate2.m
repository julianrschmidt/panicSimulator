function [h] = plotAutomate2( automateObj2 )
%PLOTAUTOMATE2 plots the outcome of the wall angle automatization process
forestGreen = [34,139,34]/255;
midnightBlue = [25 25 112]/255;
h = plot(automateObj2.wallAngleList*180/pi, automateObj2.timeNeeded, 'o', 'MarkerEdgeColor', midnightBlue, 'MarkerFaceColor',  midnightBlue);
xlabel('wall angle [deg]');
ylabel('t [s]');
title('Time needed until all agents are through door');

end