function h = plotCircle(x,y,r)
%PLOTCIRCLE plots a circle with center in [x,y] and radius r
d = r*2;
px = x-r;
py = y-r;
h = rectangle('Position',[px py d d],'Curvature',[1,1], 'FaceColor', [0,0,0], 'edgeColor','none');
%daspect([1,1,1])
end