function dispAutomateStatus( handles )
%DISPAUTOMATESTATUS Displays current automatization process in infoline
%   If automatization process is chose, displays chosen process,
%   processed runs, processed  averages
% see also: CREATEAUTOMATEOBJ, RESETAUTOMATEOBJ, AUTOMATE
automateObj = handles.automateObj;
infoString = '';
if (~strcmp(automateObj.activeAutomatedVariable,'none'))
    infoString = sprintf('Changing %s - processed: %d/%d - processed averages: %d/%d',...
                automateObj.possibleAutomatedVariables.(automateObj.activeAutomatedVariable){1},...
                automateObj.rangeIndex, length(automateObj.variableRange), ...
                automateObj.averageIndex, automateObj.averageN);
end
set(handles.infoText, 'String', infoString);
end

