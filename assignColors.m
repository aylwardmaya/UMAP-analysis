function colors = assignColors(labels, scheme)
    % INPUT: 
    %   labels = vector of values (time budget, zone, etc.)
    %   scheme = 'wheel', 'categorical', 'continuous'
    % OUTPUT:
    %   colors = n x 3 matrix of RGB values

    n = length(labels);
    colors = zeros(n,3);
switch scheme
    case 'wheel'
        colors = hsv(n);
    case 'categorical'
        colors = colormap("jet");
    case 'continuous'
        xq = linspace(0, 1, n);
        colors = interp1(linspace(0, 1, size(colormap("jet"), 1)), colormap("jet"), xq);
end