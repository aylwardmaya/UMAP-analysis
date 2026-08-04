function p = analysis(manifold, condition)
arguments
    manifold;
    condition = {"time", "offer delay", "offer zone", "wait zone", "wait zone countdown", "decision", "value", "track"};
end

%% continuous variables
if condition == "time" || condition == "offer delay" || condition == "wait zone countdown" ...
        || condition == "value" || condition == "track"
    % get null
    null_R2 = analyzeManifold(manifold, condition);

    % get real
    real_R2 = analyzeUmap(manifold, condition);

    % p values
    [p, Z, realZ] = R22Zscore(null_R2, real_R2, condition);

    % plot figure
    figure;
    tiledlayout;

    for c = 1:length(condition)
        nexttile;
        % null conditions
        histogram(Z(:, c), 'Normalization', 'probability', 'BinWidth', 0.5);
        hold on;
        xline(realZ(c), 'r', 'LineWidth', 2, 'Label', ...
            {'R²:', round(real_R2(c), 1, 'significant'), 'p:', p(c)},'LabelColor', 'k', ...
            'LabelOrientation','horizontal', 'FontSize', 18);
        title(sprintf('Condition: %s', condition(c)),'FontSize', 18);
        xlabel('Z-score', 'FontSize', 18);
        ylabel('Probability', 'FontSize', 18);
        axis square;
    end
    hold off;

%% zone variables
elseif condition == "offer zone" || condition == "wait zone" || condition == "decision"
    if condition == "offer zone" || condition == "wait zone"
    % get null
    null_variance = analyzeCat(manifold, condition);

    % get real
    real_variance = analyzeCatMap(manifold, condition);
    elseif condition == "decision"
        % get null
        null_variance = analyzeDecision(manifold, condition);

        % get real
        real_variance = analyzeRealDecision(manifold, condition);
    end

    % p values
    [p, ~] = var2Zscore(null_variance, real_variance);

    % plot figure
    figure;
    tiledlayout;

    % RHS label
    for c = 1:size(null_variance, 2)
        nexttile;
        % null conditions
        histogram(null_variance(:, c), 'Normalization', 'probability', 'BinWidth', .1);
        hold on;
        xline(real_variance(c), 'r', 'LineWidth', 5, 'Label', ...
            {'Sum of Variances:', round(real_variance(c), 1, 'significant'), 'p:', p(c)},'LabelColor', 'k', ...
             'LabelOrientation','horizontal', 'FontSize', 18);
         title(sprintf('Condition: %s', condition),'FontSize', 24);
        xlabel('Sum of Variances', 'FontSize', 24);
        ylabel('Relative Frequency', 'FontSize', 24);

        axis square;
    end
    hold off;
end