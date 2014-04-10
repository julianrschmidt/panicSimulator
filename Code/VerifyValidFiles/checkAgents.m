function [ checkBool ] = checkAgents( agents )
%CHECKAGENTS Summary of this function goes here
%   Detailed explanation goes here
if testNum(agents, 'double', [-inf,inf], [0, inf], [5,5])
    checkBool = true;
    return
end
checkBool = false;

end

