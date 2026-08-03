function [embedding_sub, behavior_shuffled] = shuffleData(manifold, condition)
arguments
    manifold;
    condition string = "offer delay";
end

% behavioral variable
if condition == "offer delay"
    behaviorData = manifold.OZ.delay.data(manifold.Q.time);
elseif condition == "value"
    behaviorData = manifold.valueTsd.data(manifold.Q.time);
elseif condition == "time"
    behaviorData = (1:manifold.n_bins)';
elseif condition == "wait zone"
    behaviorData = manifold.wzTsd.data(manifold.Q.time);
elseif condition == "offer zone"
    behaviorData = manifold.OZ.zone.data(manifold.Q.time);
elseif condition == "wait zone countdown"
    behaviorData = manifold.wzDelay.data(manifold.Q.time);
elseif condition == "track"
    behaviorData = manifold.rgbTsd.data(manifold.Q.time);
elseif condition == "decision"
    behaviorData = manifold.decisionTsd.data(manifold.Q.time);
else
    error('Unknown condition: %s', condition);
end

% subsample valid points
n_sample = 1000;
valid = all(~isnan(behaviorData), 2);
valid_embedding = manifold.E.D(valid, :);
valid_behavior = behaviorData(valid);

if sum(valid) < n_sample
    error('Not enough valid timepoints for condition: %s', condition);
end

% subsample
temp = find(valid);
idx = randperm(length(temp), n_sample);
embedding_sub = valid_embedding(temp(idx), :);
behavior_sub = valid_behavior(temp(idx));

% shuffle behavioral data only
behavior_shuffled = behavior_sub(randperm(n_sample));
end