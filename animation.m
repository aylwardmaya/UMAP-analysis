function animation(sd, manifoldOutline, coloring)

arguments
    sd;
    manifoldOutline;
    coloring = {'time', 'offer delay', 'offer zone', 'oz', 'wait zone', 'wz', ... 
        'wait zone countdown', 'wz countdown', 'decision', 'value', 'budget', 'track'};
end

%% Setup
E = manifoldOutline.E.D;
A = E(:, 1);
B = E(:, 2);

%% plot gray UMAP
figure;
scatter(A, B, 5, [0.85 0.85 0.85], 'filled', 'MarkerFaceAlpha', 0.4);
title('UMAP animation');
xlabel('UMAP 1');
ylabel('UMAP 2');
axis square;
hold on;

%% determine coloring of animation
if ismember('time', coloring)
    draw = (1:manifoldOutline.n_bins)';

elseif ismember('offer delay', coloring)
    draw = manifoldOutline.OZ.delay.data(manifoldOutline.Q.time);

elseif ismember('offer zone', coloring)
    draw = manifoldOutline.OZ.zone.data(manifoldOutline.Q.time);

elseif ismember('wait zone', coloring)
    draw = manifoldOutline.wzTsd.data(manifoldOutline.Q.time);

elseif ismember('wait zone countdown', coloring)
    draw = manifoldOutline.wzDelay.data(manifoldOutline.Q.time);

elseif ismember('value', coloring)
    draw = manifoldOutline.valueTsd.data(manifoldOutline.Q.time);

elseif ismember('decision', coloring)
    draw = manifoldOutline.wzDelay.data(manifoldOutline.Q.time);
elseif ismember('track', coloring)
    draw = manifoldOutline.rgb_aligned;
elseif ismember('3d', coloring)

end

%% start animation
mkr = animatedline('Marker','.','MarkerSize',5,'MarkerFaceColor', 'r','LineStyle','none');
axis tight; % optional: set axis limits before loop
for iT = 1:1100
    addpoints(mkr, A(iT), B(iT));
    drawnow;
end
end