function null_R2 = analyzeManifold(manifold, condition)
% null hypothesis
% condition = ["offer delay", "value", "time", "wait zone", "offer zone", "wait zone countdown", "decision", "track"];

n_shuffles = 100;
null_R2 = zeros(n_shuffles, 1); % initialize 100 x conditions matrix of R^2
% for c = 1:length(condition)
    fprintf('Running condition: %s\n', condition);
    for iter = 1:n_shuffles
        try
            [embedding_sub, behavior_shuffled] = shuffleData(manifold, condition); % shuffle D
            [X, Y] = pairwiseDistDiff(embedding_sub, behavior_shuffled); % get diff/dist matrices
            Mdl = fitrlinear(X, Y, 'Learner', 'leastsquares', 'Lambda', 0.1); % linear regression
        
            y_pred = predict(Mdl, X);
            SS_res = sum((Y - y_pred).^2);
            SS_tot = sum((Y - mean(Y)).^2);
            null_R2(iter, 1) = 1 - SS_res/SS_tot; % get R^2 value
        catch e
            fprintf('Error on condition %s, iter %d: %s\n', condition, iter, e.message);
            null_R2(iter, 1) = NaN;
            keyboard;
        end
    end