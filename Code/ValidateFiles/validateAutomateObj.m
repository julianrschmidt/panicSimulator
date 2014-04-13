function [ validatedBool ] = validateAutomateObj( automateObj )
%VALIDATEAUTOMATEOBJ validates if automateObj is of right format
if ~isstruct(automateObj)
    validatedBool = false;
    return
elseif any(size(automateObj,1) ~= 1 || size(automateObj,2) ~= 1)
    validatedBool = false;
    return
end
testAutomateObj = createAutomateObj();
fieldNames = fieldnames(testAutomateObj);

if isfield(automateObj, fieldNames)
    if any(~ischar(automateObj.activeAutomatedVariable)||...
            ~islogical(automateObj.plotIndividualExitTimesBool)||...
            ~validateNum(automateObj.variableRange, 'double', [-inf, inf], [0, 1], [0,inf])||...
            ~validateNum(automateObj.averageN, 'int', [1,inf], [1,1], [1,1])||...
            ~validateNum(automateObj.rangeIndex, 'int', [1, inf], [1,1], [1,1])||...
            ~validateNum(automateObj.exitTimes, 'double', [-inf, inf], [0,inf], [0,1])||...
            ~validateNum(automateObj.individualExitTimes, 'double', [-inf, inf], [0,inf], [0,inf])||...
            ~validateNum(automateObj.runN, 'int', [0, inf], [1,1], [1,1])||...
            ~validateNum(automateObj.hFigIndividualExitTimes, 'double', [-inf, inf], [0,1], [0,1]))
        validatedBool = false;
        return
    else
        possibleAutomatedVariablesStrings = fieldnames(testAutomateObj.possibleAutomatedVariables);
        if ~any(strcmp(automateObj.activeAutomatedVariable, possibleAutomatedVariablesStrings))
            validatedBool = false;
            return
        end
    end
else
    validatedBool = false;
    return
end
validatedBool = true;
end

