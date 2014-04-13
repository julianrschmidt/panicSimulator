function warningsOff( )
%WARNINGSOFF Switches some warnings off

%warning that no frames have been written in video file
warning('off', 'MATLAB:audiovideo:VideoWriter:noFramesWritten');

end

