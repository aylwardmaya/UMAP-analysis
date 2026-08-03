function manifold = session_to_umap(sd, Sreg, binSize, NumDimensions, NumNeighbors, options)
arguments
    sd;
    Sreg char;
    binSize double = 0.1;
    NumDimensions double = 2;
    NumNeighbors double = 100;


    options.restrict = [];
end

S = Pull_ROI_Spikes(sd, Sreg);

% TC = TuningCurves_C(S, {sd.y});

Q = MakeQfromS(S, binSize);
if ~isempty(options.restrict)
    Q = Q.restrict(sd.ExpKeys.TimeOnTrack, sd.ExpKeys.TimeOnTrack + options.restrict);
end

%% UMAP set up
embedding = umap(Q.D, 'NumDimensions', NumDimensions, 'NumNeighbors', NumNeighbors);

E = tsd(Q.time, embedding);
n_bins = size(Q.D,1);

% aligns colors to time points
    x = sd.x;
    y = sd.y;
    rgb_colors = track_color_wheel(x, y);
    index = interp1(x.T, 1:length(x.T), E.T, 'nearest', 'extrap');
    rgb_aligned = rgb_colors(index, :);
    rgbTsd = tsd(Q.time, rgb_aligned);

% offer zone
OZ = RR_OfferDelayTsd(sd);

% wait zone
[wzDelay, wzTsd] = waitzone(sd);

% decision
decisionTsd = decision(sd);

% value w/ threshold
valueTsd = value(sd);

[OzoneData, WzoneData] = getzones(sd);

% umap_info to ManifoldOutline
manifold = ManifoldOutline(E, rgb_colors, rgb_aligned, rgbTsd, n_bins, Q, Sreg, ...
    OZ, wzDelay, wzTsd, decisionTsd, valueTsd, OzoneData, WzoneData, NumNeighbors, NumDimensions);

end