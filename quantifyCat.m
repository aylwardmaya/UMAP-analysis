function embedding_sub = quantifyCat(manifold, condition, zone)
arguments
    manifold;
    condition string = "wait zone";
    zone double = 1;
end

% behavioral variable
if condition == "wait zone" && zone == 1
    Bdata = manifold.WzoneData.zone1Tsd.data(manifold.Q.time);
elseif condition == "wait zone" && zone == 2
    Bdata = manifold.WzoneData.zone2Tsd.data(manifold.Q.time);
elseif condition == "wait zone" && zone == 3
    Bdata = manifold.WzoneData.zone3Tsd.data(manifold.Q.time);
elseif condition == "wait zone" && zone == 4
    Bdata = manifold.WzoneData.zone4Tsd.data(manifold.Q.time);
elseif condition == "offer zone" && zone == 5
    Bdata = manifold.OzoneData.zone5Tsd.data(manifold.Q.time);
elseif condition == "offer zone" && zone == 6
    Bdata = manifold.OzoneData.zone6Tsd.data(manifold.Q.time);
elseif condition == "offer zone" && zone == 7
    Bdata = manifold.OzoneData.zone7Tsd.data(manifold.Q.time);
elseif condition == "offer zone" && zone == 8
    Bdata = manifold.OzoneData.zone8Tsd.data(manifold.Q.time);
elseif condition == "decision"
    % Bdata = manifold.decisionTsd.data(manifold.Q.time);
else
    error('Unknown condition: %s', condition);
end

% find valid zone timepoints
valid = all(~isnan(Bdata), 2);
valid_idx = find(valid);
n_sample = length(valid_idx);

% get embedding points for THIS zone only
embedding_sub = manifold.E.D(valid_idx, :);

end