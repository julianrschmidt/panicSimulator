function [ automateObj ] = resetAutomateObj( automateObj)
%RESETAUTOMATEOBJ Resets all indices of the automateObj to initial
%   Also deletes stored times
%   automateNrReset: specifies which of the automate possiblities to reset
%                    if it is 0, all will be reset
% see also: CREATEAUTOMATEOBJ, AUTOMATE, DISPAUTOMATESTATUS

automateObj.rangeIndex = 1;
automateObj.averageIndex = 1;
automateObj.exitTimes = zeros(length(automateObj.variableRange), 1);

end

