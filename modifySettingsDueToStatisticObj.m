function [ settings ] = modifySettingsDueToStatisticObj( statisticObj, settings )
%MODIFYSETTINGSDUETOSTATISTICOBJ Summary of this function goes here
%   Detailed explanation goes here
for index = 2:length(statisticObj)
    statisticNr = statisticObj{index}.statisticNr;
    switch statisticNr
        case 1
            settings.vDes = statisticObj{index}.vDesList(1);
        case 2
            settings = setWallAngle(settings,statisticObj{index}.wallAngleList(1));
    end
end

