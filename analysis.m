function [p, result] = analysis(manifold, condition)
arguments
    manifold;
    condition = "time";
end

%% continuous variables
if condition == "time" || ...
        condition == "offer delay" ...
        || condition == "wait zone countdown" ...
        || condition == "value" ...
        || condition == "track"
    % get null
    null_R2 = analyzeManifold(manifold, condition);

    % get real
    real_R2 = analyzeUmap(manifold, condition);

    % p values
    [p, Z, realZ] = R22Zscore(null_R2, real_R2, condition);

    result.real = real_R2;
    result.null = null_R2;
    result.Z = Z;
    result.realZ = realZ;

%% zone variables
elseif condition == "offer zone" || ...
        condition == "wait zone" || ...
        condition == "decision"
    
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

    [p, Z, realZ] = var2Zscore(null_variance, real_variance);

        result.real = real_variance;
        result.null = null_variance;
        result.Z = Z;
        result.realZ = realZ;
end
end
