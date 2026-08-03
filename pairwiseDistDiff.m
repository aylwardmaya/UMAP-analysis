function [X, Y] = pairwiseDistDiff(embedding, behavior)
% both null and real

% pairwise distances
distanceMatrix = pdist2(embedding, embedding, 'euclidean');
differenceMatrix = pdist2(behavior, behavior, 'euclidean');

n_sample = 1000;
% upper triangle only
mask = triu(true(n_sample), 1);
X = differenceMatrix(mask);
Y = distanceMatrix(mask);

end