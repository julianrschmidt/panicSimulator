function [ settings ] = modifySettingsDueToAutomateObj( automateObj, settings )
%MODIFYSETTINGSDUETOAUTOMATEOBJ Summary of this function goes here
%   Detailed explanation goes here
for index = 2:length(automateObj)
    automateNr = automateObj{index}.automateNr;
    switch automateNr
        case 1
            settings.vDes = automateObj{index}.vDesList(1);
        case 2
            settings = setWallAngle(settings,automateObj{index}.wallAngleList(1));
    end
end

