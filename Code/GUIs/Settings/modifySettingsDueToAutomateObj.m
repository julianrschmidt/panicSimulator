function [ settings ] = modifySettingsDueToAutomateObj( automateObj, settings )
%MODIFYSETTINGSDUETOAUTOMATEOBJ some variables in settings need to be
%   changed, when automateObj is created. This is done here.
for index = 2:length(automateObj)
    automateNr = automateObj{index}.automateNr;
    switch automateNr
        case 1
            settings.vDes = automateObj{index}.vDesList(1);
        case 2
            settings = setWallAngle(settings,automateObj{index}.wallAngleList(1));
    end
end

