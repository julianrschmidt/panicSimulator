function hExitLine = plotExitLine( x, y )
%PLOTEXITLINE plots the green-red exit line from (x1,y1) to (x2,y2)
green = [127 255 0]/255;
red = [255 69 0]/255;
hExitLine = zeros(1,2);
thickness = 0.3; %thickness of door in cm
nx = y(1) - y(2);
ny = x(2) - x(1);
nLength = sqrt(nx.^2 + ny.^2);
nx = nx./nLength;
ny = ny./nLength;

hExitLine(1) = patch([x';x(2:-1:1)'+nx*thickness/2], ...
    [y';y(2:-1:1)'+ny*thickness/2], zeros(4,1) ,...
    'FaceColor', green, 'edgeColor','none');
hExitLine(2) = patch([x';x(2:-1:1)'-nx*thickness/2], ...
    [y';y(2:-1:1)'-ny*thickness/2], zeros(4,1) ,...
    'FaceColor', red, 'edgeColor','none');
end

