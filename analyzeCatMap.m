function real_var = analyzeCatMap(manifold, condition)
arguments
    manifold;
    condition string = "wait zone";
end

if condition == "wait zone"
    zones = [1 2 3 4];
elseif condition == "offer zone"
    zones = [5 6 7 8];
end

n_iterations = 250; % run 250 times per condition
real_var = zeros(1, 4);

for i = 1:length(zones)
    z = zones(i);
    fprintf('Running: %s\n', condition);
    for iter = 1:n_iterations
        try
             embedding_sub = quantifyCat(manifold, condition, z);
             real_var(i) = sum(var(embedding_sub));
        catch e
            fprintf('Error on %s, iter %d: %s\n', condition, iter, e.message);
            all_det(iter, z) = NaN;
            % keyboard;
        end
    end
end

real_var = mean(real_var, 1, 'omitnan');

end