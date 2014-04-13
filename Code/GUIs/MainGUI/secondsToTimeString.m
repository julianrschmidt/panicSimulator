function [ timeString ] = secondsToTimeString( s )
%SECONDSTOTIMESTRING returns time in format mm:ss.ss
%   s - time in seconds
timeString = sprintf('%02d:%02d.%02d', floor(s/60), floor(mod(s, 60)), floor(mod(s, 1)*100));

end

