function null_var = analyzeDecision(manifold, condition)
arguments
    manifold;
    condition string = "decision";
end


n_shuffles = 200;
null_var = zeros(n_shuffles, 3); % initialize 100 x conditions matrix of determinants

if condition == "decision"
    zones = [0 1 2];
end

for i = 1:length(zones)
    z = zones(i);
    for iter = 1:n_shuffles
        try
            embedding_shuffled = shuffleDecision(manifold, condition, z); % shuffle D
            null_var(iter, i) = sum(var(embedding_shuffled)); % store in column i not z

        catch e
            fprintf('Error on %s, iter %d: %s\n', condition, iter, e.message);
            null_var(iter, z) = NaN;
            keyboard;
        end
    end
end
end