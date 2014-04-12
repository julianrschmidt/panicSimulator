function dispStatisticStatus( handles )
%DISPSTATISTICSTATUS Summary of this function goes here
%   Detailed explanation goes here
statisticObj = handles.statisticObj;
infoString = '';
for index = 2:length(statisticObj{1}) + 1
    statisticNr = statisticObj{index}.statisticNr;
    switch statisticNr
        case 1
            infoString = sprintf('Changing desired velocity - processed velocities: %d/%d - processed averages: %d/%d',...
                statisticObj{index}.vDesIndex, length(statisticObj{index}.vDesList), ...
                statisticObj{index}.averageIndex, statisticObj{index}.averageN);
        case 2
            infoString = sprintf('Changing wall angle - processed angles: %d/%d - processed averages: %d/%d',...
                statisticObj{index}.wallAngleIndex, length(statisticObj{index}.wallAngleList), ...
                statisticObj{index}.averageIndex, statisticObj{index}.averageN);
    end
end
set(handles.infoText, 'String', infoString);
end

