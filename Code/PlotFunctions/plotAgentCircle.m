function h = plotAgentCircle(x,y,r)
%PLOTAGENTCIRCLE plots a circle with center in [x,y] and radius r
forestGreen = [34,139,34]/255;
d = r*2;
px = x-r;
py = y-r;
h = rectangle('Position',[px py d d],'Curvature',[1,1], 'FaceColor', forestGreen, 'edgeColor','none');
%daspect([1,1,1])
end