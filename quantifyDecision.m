function embedding_sub = quantifyDecision(manifold, condition, zone)
arguments
    manifold;
    condition string = "decision";
    zone double = 1;
end

% get decision values aligned to Q matrix timepoints
decisionData = manifold.decisionTsd.data(manifold.Q.time);

% find timepoints where decision matches the requested zone
valid_idx = find(decisionData == zone);

if isempty(valid_idx)
    error('No timepoints found for decision zone %d', zone);
end

% get embedding points for this decision type only
embedding_sub = manifold.E.D(valid_idx, :);

end