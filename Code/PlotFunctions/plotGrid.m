function [ hCells ] = plotGrid( limits )
%PLOTGRID plots a collegeblock like background with 1 m between each block

xMin = limits(1);
xMax = limits(2);
yMin = limits(3);
yMax = limits(4);
Nx = ceil(xMax-xMin);
Ny = ceil(yMax-yMin);
dx = 1;
dy = 1;

hCells = zeros(Nx, Ny);
for i = 1:Nx
    for j = 1:Ny
    
        hCells(i, j) = rectangle('Position',[xMin+(i-1)*dx, yMin + (j-1)*dy, dx, dy], ...
            'FaceColor',[1, 1, 1], 'edgeColor',[0.8,0.8,0.8]);
    end
end

end

