function null_var = analyzeCat(manifold, condition)
arguments
    manifold;
    condition string = "wait zone";
end


n_shuffles = 200;
null_var = zeros(n_shuffles, 4); % initialize 100 x conditions matrix of determinants

if condition == "wait zone"
    zones = [1 2 3 4];
elseif condition == "offer zone"
    zones = [5 6 7 8];
end

for i = 1:length(zones)
    z = zones(i);
    for iter = 1:n_shuffles
        try
            embedding_shuffled = shuffleCat(manifold, condition, z); % shuffle D
            null_var(iter, i) = sum(var(embedding_shuffled)); % store in column i not z

        catch e
            fprintf('Error on %s, iter %d: %s\n', condition, iter, e.message);
            null_var(iter, z) = NaN;
            keyboard;
        end
    end
end
end