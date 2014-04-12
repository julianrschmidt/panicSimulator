function dispAutomateStatus( handles )
%DISPAUTOMATESTATUS Displays current automatization process in infoline
%   If automatization process is chose, displays chosen process,
%   processed runs, processed  averages
% see also: CREATEAUTOMATEOBJ, RESETAUTOMATEOBJ, AUTOMATE
automateObj = handles.automateObj;
infoString = '';
for index = 2:length(automateObj{1}) + 1
    automateNr = automateObj{index}.automateNr;
    switch automateNr
        % automatic change in velocity
        case 1
            infoString = sprintf('Changing desired velocity - processed velocities: %d/%d - processed averages: %d/%d',...
                automateObj{index}.vDesIndex, length(automateObj{index}.vDesList), ...
                automateObj{index}.averageIndex, automateObj{index}.averageN);
        % automatic change in wall angle
        case 2
            infoString = sprintf('Changing wall angle - processed angles: %d/%d - processed averages: %d/%d',...
                automateObj{index}.wallAngleIndex, length(automateObj{index}.wallAngleList), ...
                automateObj{index}.averageIndex, automateObj{index}.averageN);
    end
end
set(handles.infoText, 'String', infoString);
end

