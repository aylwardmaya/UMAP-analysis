function rgb_colors = track_color_wheel(x, y)
    x_center = (max(x.D) + min(x.D))/2;
    y_center = (max(y.D) + min(y.D))/2;

    theta = atan2(y.D - y_center, x.D - x_center);

    hue = mod(theta, 2*pi) / (2*pi);
    saturation = ones(size(hue));

    value = ones(size(hue));
    
    hsv_map = [hue, saturation, value];
    rgb_colors = hsv2rgb(hsv_map);
end