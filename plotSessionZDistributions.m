function [sessionZ, figures] = plotSessionZDistributions(R)
% One observed-vs-shuffled Z score per session, region, and condition.

n_regions = numel(R.Sreg);
n_conditions = numel(R.conditions);

sessionZ = nan(R.nS, n_regions, n_conditions);
figures = gobjects(n_regions, 1);

%% Calculate session Z scores
for iR = 1:n_regions
    for iC = 1:n_conditions
        for iS = 1:R.nS

            result = R.results{iS, iR, iC};

            if isempty(result) || ~isstruct(result) || ...
                    ~isfield(result, 'real') || ~isfield(result, 'null')
                continue
            end

            observed = result.real(:).';
            shuffled = result.null;

            if isempty(observed) || isempty(shuffled) || ...
                    size(shuffled, 2) ~= numel(observed) || ...
                    any(~isfinite(observed))
                continue
            end

            % Only keep shuffled iterations with all categories present
            shuffled = shuffled(all(isfinite(shuffled), 2), :);

            if isempty(shuffled)
                continue
            end

            % difference between observed and shuffled summed statistic
            observedStat = sum(observed);
            shuffledStat = sum(shuffled, 2);

            mu = mean(shuffledStat);
            sigma = std(shuffledStat);

    if sigma > 0

            conditionName = string(R.conditions{iC});
        
            if conditionName == "offer zone" || ...
               conditionName == "wait zone" || ...
               conditionName == "decision"
        
                % Categorical:
                % Lower within-category variance = stronger representation
                % Therefore "good" categorical representation = positive Z
                sessionZ(iS, iR, iC) = ...
                    (mu - observedStat) / sigma;
        
            else
        
                % Continuous:
                % Higher R^2 = stronger representation
                % Therefore "good" continuous representation = positive Z
                sessionZ(iS, iR, iC) = ...
                    (observedStat - mu) / sigma;
            end
    end
        
        end
    end
end

%% Plot one figure for each region
for iR = 1:n_regions

    figures(iR) = figure( ...
        'Name', sprintf('%s Session Z Distributions', R.Sreg{iR}), ...
        'Color', 'w');

    % One row, one tile per condition
    t = tiledlayout(2, 4, ...
        'TileSpacing', 'compact', ...
        'Padding', 'compact');

    title(t, sprintf('%s Session Z Distributions', R.Sreg{iR}));

    for iC = 1:n_conditions

        ax = nexttile;

        z = sessionZ(:, iR, iC);
        z = z(isfinite(z));

        histogram(ax, z, 50);
        axis square;

        title(ax, R.conditions{iC});
        xlabel(ax, 'Session Z-score');
        ylabel(ax, 'Number of sessions');

        grid(ax, 'on');
        box(ax, 'off');
    end
end
end