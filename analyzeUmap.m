function real_R2 = analyzeUmap(manifold, condition)
% for comparison to null

% condition = ["offer delay", "value", "time", "wait zone", "offer zone", "wait zone countdown", "decision", "track"];

n_iterations = 250; % run 250 times per condition
all_R2 = zeros(n_iterations, 1);
% for c = 1:length(condition)
    fprintf('Running condition: %s\n', condition);
    for iter = 1:n_iterations
        try
            [embedding, behavior] = quantifyUmap(manifold, condition);
            [X, Y] = pairwiseDistDiff(embedding, behavior); % get diff/dist matrices
            Mdl = fitrlinear(X, Y, 'Learner', 'leastsquares', 'Lambda', 0.1);
            
            y_pred = predict(Mdl, X);
            SS_res = sum((Y - y_pred).^2);
            SS_tot = sum((Y - mean(Y)).^2);
            all_R2(iter, 1) = 1 - SS_res/SS_tot;
        catch e
            all_R2(iter, 1) = NaN;
        end
    end


real_R2 = round(mean(all_R2, 1, 'omitnan'), 1, 'significant');

end