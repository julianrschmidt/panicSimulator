function hWallLine = plotWallLine( x, y )
%PLOTWALLLINE plots a wall line from (x1,y1) to (x2,y2)

midnightBlue = [25 25 112]/255;
thickness = 0.3; %thickness of door in cm
nx = y(1) - y(2);
ny = x(2) - x(1);
nLength = sqrt(nx.^2 + ny.^2);
nx = nx./nLength;
ny = ny./nLength;

hWallLine = patch([x'-nx*thickness/2;x(2:-1:1)'+nx*thickness/2], ...
    [y'-ny*thickness/2;y(2:-1:1)'+ny*thickness/2], zeros(4,1) ,...
    'FaceColor', midnightBlue, 'edgeColor','none');

end

