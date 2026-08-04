function [p, Z] = var2Zscore(null_var, real_var)
    s = size(null_var, 2);
    realZ = zeros(1,s);
    for i = 1:s
        mu = zeros(1,s); 
        sigma = zeros(1,s);
        Z = zeros(size(null_var));

        [Z(:, i), mu(i), sigma(i)] = zscore(null_var(:, i));
        Z = zscore(null_var); % overwrite Z
        % calculate the z-scores for the real R2 values
        realZ(i) = ((real_var(i) - mu(i)) ./ sigma(i));
    end

    % p values
    p = zeros(1, size(null_var, 2));
    for i = 1:size(null_var, 2)
        p(i) = round((sum(null_var(i) <= real_var(i)) + 1) / (200 + 1), 1, 'significant');    
    end
end