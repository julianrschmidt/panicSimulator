function [ radii ] = createAgentRadii( NAgent )
%CREATEAGENTRADII Creates realistic radii of human, according to statistics
%   takes random radius values from heuristic statistics of real body sizes
x = ([37.8, 38.2, 38.7, 39.6, 41.1, 42.6, 43.5, 44.1, 45] + 13)/2/100;
p =  [5, 10, 15, 25, 50, 75, 85, 90, 95] / 100;
ur =  rand(NAgent,1);
radii = interp1(p,x,ur,'linear','extrap');


end

