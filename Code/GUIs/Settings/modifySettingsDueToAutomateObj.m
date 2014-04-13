function [ settings ] = modifySettingsDueToAutomateObj( automateObj, settings )
%MODIFYSETTINGSDUETOAUTOMATEOBJ some variables in settings need to be
%   changed, when automateObj is created. This is done here.
if ~strcmp(automateObj.activeAutomatedVariable, 'none')
    val = automateObj.variableRange(1);
    setterFunc = automateObj.possibleAutomatedVariables.(automateObj.activeAutomatedVariable){4};
    settings = setterFunc(settings, val);
end
end

