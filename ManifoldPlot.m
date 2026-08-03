function ManifoldPlot(sd, manifoldOutline, condition)

% ManifoldPlot - plots UMAP manifold with behavioral overlays
%
% INPUTS:
%   sd        - session data struct from TaskInit
%   umap_info - ManifoldOutline object from session_to_umap
%   plots     - choose which plots to display

arguments
    sd;
    manifoldOutline;
    condition = {'time', 'offer delay', 'offer zone', 'oz', 'wait zone', 'wz', ... 
        'wait zone countdown', 'wz countdown', 'decision', 'value', 'budget', '3d', 'track'};
end

%% Setup
E = manifoldOutline.E.D;
A = E(:, 1);
B = E(:, 2);

%% Figure 1 - behavioral
figure;
t = tiledlayout('flow');
title(t, sd.ExpKeys.SSN, manifoldOutline.Sreg);

% Time
if ismember('time', condition)
    nexttile;
    scatter(A, B, 5, (1:manifoldOutline.n_bins)', 'filled');
    colorbar;
    colormap(jet);
    title('UMAP by time');
    xlabel('UMAP 1');
    ylabel('UMAP 2');
    axis square;
end

% Offer Delay
if ismember('offer delay', condition)
    nexttile;
    scatter(A, B, 5, manifoldOutline.OZ.delay.data(manifoldOutline.Q.time), 'filled');
    title('Offer Delay');
    colorbar;
    colormap(jet);
    xlabel('UMAP 1');
    ylabel('UMAP 2');
    axis square;
end

% Offer Zone
if ismember('offer zone', condition)
    nexttile;
    gscatter(A, B, manifoldOutline.OZ.zone.data(manifoldOutline.Q.time), [], [], 5);
    title('Offer Zone');
    xlabel('UMAP 1');
    ylabel('UMAP 2');
    axis square;

end

% Wait Zone
if ismember('wait zone', condition)
    nexttile;
    gscatter(A, B, manifoldOutline.wzTsd.data(manifoldOutline.Q.time), [], [], 5);
    title('Wait Zone');
    xlabel('UMAP 1');
    ylabel('UMAP 2');
    axis square;

end

% Wait Zone Countdown
if ismember('wait zone countdown', condition)
    nexttile;
    scatter(A, B, 5, manifoldOutline.wzDelay.data(manifoldOutline.Q.time), 'filled');
    title('Wait Zone Countdown');
    colorbar;
    colormap(jet);
    xlabel('UMAP 1');
    ylabel('UMAP 2');
    axis square;

end

% Decision
if ismember('decision', condition)
    nexttile;
    colors = [0.1 0.8 0.1;   % quit - gray green
        0.2 0.6 1.0;   % skip - blue
        0.7 0.7 0.7];  % accept - green gray
    gscatter(A, B, manifoldOutline.decisionTsd.data(manifoldOutline.Q.time), colors, [], 5);
    title('Decision - 0=quit, 1=skip, 2=accept');
    xlabel('UMAP 1');
    ylabel('UMAP 2');
    axis square;

    % decision threshold
    % hold on;
    % [a, b] = RR_BehaviorThresholds(sd, "perRestaurant",2,'threshDef',"showFig")

end

% Value
if ismember('value', condition)
    h = nexttile;
    scatter(A, B, 5, manifoldOutline.valueTsd.data(manifoldOutline.Q.time), 'filled');
    colorbar;
    colormap(h, valueColors(manifoldOutline.valueTsd));
    title('Value');
    xlabel('UMAP 1');
    ylabel('UMAP 2');
    axis square;
end



% track color wheel
if ismember('track', condition)
nexttile;
scatter(A, B, 5, manifoldOutline.rgb_aligned, 'filled');
title('UMAP - track position');
xlabel('UMAP 1');
ylabel('UMAP 2');
axis square;

nexttile;
scatter(sd.x.D, sd.y.D, 5, manifoldOutline.rgb_colors, 'filled');
title('Track legend');
axis square;
end

if ismember('3d', condition)
    % figure;
    % scatter3(manifoldOutline.Q.time, A, B, 5, (1:manifoldOutline.n_bins)', 'filled');
    % figure;
    % scatter(manifoldOutline.Q.time, B, 5, (1:manifoldOutline.n_bins)', 'filled');
    % figure;     scatter(manifoldOutline.Q.time, A, 5, (1:manifoldOutline.n_bins)', 'filled');

end
end