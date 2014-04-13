function [h] = plotAutomate( automateObj )
%PLOTAUTOMATE1 plots the outcome of the velocity automatization process

forestGreen = [34,139,34]/255;
midnightBlue = [25 25 112]/255;
h = plot(automateObj.variableRange, automateObj.exitTimes, 'o', 'MarkerEdgeColor', midnightBlue, 'MarkerFaceColor',  midnightBlue);
aliasName = automateObj.possibleAutomatedVariables.(automateObj.activeAutomatedVariable){1};
xlabel(aliasName);
ylabel('t [s]');
title(sprintf('Averaged exit times in dependence of %s', aliasName));

end

