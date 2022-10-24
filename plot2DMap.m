function out = plot2DMap( m, path )
    imagesc(m)
    for i=1:size(path,1)
        hold on;
        plot(path(i,2), path(i,1), '.b', 'MarkerSize', 20);
    end
    set(gca, 'Ydir', 'normal');
    cmap = [1 1 1; 0 0 0];
    colormap(cmap);
    caxis([0 1]);
    grid
end

