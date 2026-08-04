function real_var = analyzeRealDecision(manifold, condition)
arguments
    manifold;
    condition string = "decision";
end

zones = [0 1 2];
real_var = zeros(1, 3);

for i = 1:length(zones)
    embedding_sub = quantifyDecision(manifold, condition, zones(i));
    real_var(i) = sum(var(embedding_sub));
end
end