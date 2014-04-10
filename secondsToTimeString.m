function [ timeString ] = secondsToTimeString( s )
%SECONDSTOTIMESTRING Summary of this function goes here
%   Detailed explanation goes here
timeString = sprintf('%02d:%02d.%02d', floor(s/60), floor(mod(s, 60)), floor(mod(s, 1)*100));

end

