function dispAutomateStatus( handles )
%DISPAUTOMATESTATUS Summary of this function goes here
%   Detailed explanation goes here
automateObj = handles.automateObj;
infoString = '';
for index = 2:length(automateObj{1}) + 1
    automateNr = automateObj{index}.automateNr;
    switch automateNr
        case 1
            infoString = sprintf('Changing desired velocity - processed velocities: %d/%d - processed averages: %d/%d',...
                automateObj{index}.vDesIndex, length(automateObj{index}.vDesList), ...
                automateObj{index}.averageIndex, automateObj{index}.averageN);
        case 2
            infoString = sprintf('Changing wall angle - processed angles: %d/%d - processed averages: %d/%d',...
                automateObj{index}.wallAngleIndex, length(automateObj{index}.wallAngleList), ...
                automateObj{index}.averageIndex, automateObj{index}.averageN);
    end
end
set(handles.infoText, 'String', infoString);
end

