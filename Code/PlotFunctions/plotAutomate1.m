function [h] = plotAutomate1( automateObj1 )
%PLOTAUTOMATE1 plots the outcome of the velocity automatization process

forestGreen = [34,139,34]/255;
midnightBlue = [25 25 112]/255;
h = plot(automateObj1.vDesList, automateObj1.timeNeeded, 'o', 'MarkerEdgeColor', midnightBlue, 'MarkerFaceColor',  midnightBlue);
xlabel('desired velocity [m/s]');
ylabel('t [s]');
title('Time needed until all agents are through door');

end

