function [p, Z, realZ] = R22Zscore(null_R2, real_R2, condition)
    s = length(real_R2);
    realZ = zeros(s);
    for i = 1:s
        mu = zeros(1,s); 
        sigma = zeros(1,s);
        Z = zeros(size(null_R2));

        [Z(:, i), mu(i), sigma(i)] = zscore(null_R2(:, i));
        Z = zscore(null_R2); % overwrite Z
        % calculate the z-scores for the real R2 values
        realZ(i) = round((real_R2(i) - mu(i)) ./ sigma(i), 1, 'significant');
    end

    % p-values
    p = zeros(1, length(condition));
    for i = 1:length(condition)
        p(1, i) =  round(1 - chi2cdf(realZ(i), 1), 1, 'significant'); % calculate p-value for each condition
    end
end