function [p, Z, realZ] = var2Zscore(null_var, real_var)
s = size(null_var, 2);
Z = zeros(size(null_var));
realZ = zeros(1, s);
p = zeros(1, s);

for i = 1:s

    mu = mean(null_var(:, i), 'omitnan');
    sigma = std(null_var(:, i), 'omitnan');

    if sigma > 0

        % Z-scores of shuffled/null distribution
        Z(:, i) = (null_var(:, i) - mu) ./ sigma;

        % Categorical:
        % lower variance = tighter clustering = better
        % therefore good representation should be POSITIVE
        realZ(i) = (mu - real_var(i)) ./ sigma;

    else
        Z(:, i) = NaN;
        realZ(i) = NaN;
    end

    % p-value: probability of shuffled variance being
    % as small or smaller than the real variance
    validNull = null_var(isfinite(null_var(:, i)), i);

    p(i) = (sum(validNull <= real_var(i)) + 1) / ...
           (numel(validNull) + 1);
end

end
