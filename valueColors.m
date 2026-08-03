function asymMap = valueColors(valueTsd)
asymMap = zeros(size(valueTsd)); % Initialize the output map

% Define data bounds
min_val = min(valueTsd.D); 
max_val = max(valueTsd.D);
total_colors = 256;

% Calculate the exact row index where zero should fall
zero_idx = round(total_colors * (0 - min_val) / (max_val - min_val));

% Define endpoint colors [R, G, B]
negative_color = [0.8, 0, 0];  % Red
white          = [1, 1, 1];    % White
positive_color = [0, 0, 0.8];  % Blue

% negative side (Negative Color -> White)
neg_map = [linspace(negative_color(1), white(1), zero_idx)', ...
    linspace(negative_color(2), white(2), zero_idx)', ...
    linspace(negative_color(3), white(3), zero_idx)'];

% positive side (White -> Positive Color)
pos_colors_count = total_colors - zero_idx;
pos_map = [linspace(white(1), positive_color(1), pos_colors_count)', ...
    linspace(white(2), positive_color(2), pos_colors_count)', ...
    linspace(white(3), positive_color(3), pos_colors_count)'];

% combine maps and apply
asymMap = [neg_map; pos_map];

end
