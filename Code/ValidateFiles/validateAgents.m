function [ validatedBool ] = validateAgents( agents )
%VALIDATEAGENTS Summary of this function goes here
%   Detailed explanation goes here
if validateNum(agents, 'double', [-inf,inf], [0, inf], [5,5])
    validatedBool = true;
    return
end
validatedBool = false;

end

