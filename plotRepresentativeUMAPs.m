function comparison = plotRepresentativeUMAPs(R, sessionZ)
%
% INPUTS
%   R
%       Analysis structure containing:
%           R.Sreg
%           R.conditions
%           R.Rat
%           R.SSN
%
%   sessionZ
%       nSessions x nRegions x nConditions array of session Z-scores
%
% OUTPUT
%   comparison
%       struct containing representative sessions and Z-scores


%% Setup
baseDir = '/Volumes/ADRLAB/2025 CMG RRow';
saveDir = '/Users/mayaaylward/Desktop/RepresentativeUMAPs';

if ~isfolder(saveDir)
    mkdir(saveDir);
end

nRegions = numel(R.Sreg);
nConditions = numel(R.conditions);

comparison = struct();


%% Loop through regions and conditions

for iR = 1:nRegions
    region = R.Sreg{iR};

    for iC = 1:nConditions
        condition = R.conditions{iC};

        %% Get session Z scores
        z = squeeze(sessionZ(:, iR, iC));

        validSessions = find(isfinite(z));
        validZ = z(validSessions);

        if isempty(validZ)
            fprintf('No valid sessions for %s | %s\n', ...
                string(region), string(condition));
            continue
        end


        %% Quantitative summary
        meanZ = mean(validZ);
        stdZ = std(validZ);

        % Minimum Z session
        [~, idx] = min(validZ);
        lowSession = validSessions(idx);
        lowZ = z(lowSession);

        % Maximum Z session
        [~, idx] = max(validZ);
        highSession = validSessions(idx);
        highZ = z(highSession);

        % Representative / "average" session
        [~, idx] = min(abs(validZ - meanZ));
        typicalSession = validSessions(idx);
        typicalZ = z(typicalSession);

        % Formal outliers
        lowerThreshold = meanZ - 2*stdZ;
        upperThreshold = meanZ + 2*stdZ;

        lowOutliers = validSessions(validZ < lowerThreshold);
        highOutliers = validSessions(validZ > upperThreshold);


        %% Save information
        comparison(iR,iC).region = region;
        comparison(iR,iC).condition = condition;

        comparison(iR,iC).meanZ = meanZ;
        comparison(iR,iC).stdZ = stdZ;

        comparison(iR,iC).lowSession = lowSession;
        comparison(iR,iC).lowZ = lowZ;

        comparison(iR,iC).typicalSession = typicalSession;
        comparison(iR,iC).typicalZ = typicalZ;

        comparison(iR,iC).highSession = highSession;
        comparison(iR,iC).highZ = highZ;

        comparison(iR,iC).lowOutliers = lowOutliers;
        comparison(iR,iC).highOutliers = highOutliers;


        %% Print summary
        fprintf('\n%s | %s\n', ...
            string(region), string(condition));

        fprintf('Mean Z: %.3f +/- %.3f\n', ...
            meanZ, stdZ);

        fprintf('Low:     %s, Z = %.3f\n', ...
            R.SSN{lowSession}, lowZ);

        fprintf('Typical: %s, Z = %.3f\n', ...
            R.SSN{typicalSession}, typicalZ);

        fprintf('High:    %s, Z = %.3f\n', ...
            R.SSN{highSession}, highZ);


        %% Low UMAP
        fd = fullfile(baseDir, ...
            R.Rat{lowSession}, ...
            R.SSN{lowSession});

        if isfolder(fd)

            sd = TaskInit(fd);

            manifoldOutline = session_to_umap(sd, region);

            fig = ManifoldPlot(sd, manifoldOutline, condition);

            sgtitle(sprintf( ...
                '%s | %s | LOW | %s | Z = %.2f', ...
                string(region), ...
                string(condition), ...
                R.SSN{lowSession}, ...
                lowZ));

            filename = sprintf( ...
                '%s_%s_LOW_%s.png', ...
                string(region), ...
                string(condition), ...
                R.SSN{lowSession});

            filename = strrep(filename, ' ', '_');

            exportgraphics(fig, ...
                fullfile(saveDir, filename), ...
                'Resolution', 300);

            close(fig);

        else
            warning('Could not find session folder: %s', fd);
        end


        %% Typical UMAP
        fd = fullfile(baseDir, ...
            R.Rat{typicalSession}, ...
            R.SSN{typicalSession});

        if isfolder(fd)

            sd = TaskInit(fd);

            manifoldOutline = session_to_umap(sd, region);

            fig = ManifoldPlot(sd, manifoldOutline, condition);

            sgtitle(sprintf( ...
                '%s | %s | TYPICAL | %s | Z = %.2f | mean Z = %.2f', ...
                string(region), ...
                string(condition), ...
                R.SSN{typicalSession}, ...
                typicalZ, ...
                meanZ));

            filename = sprintf( ...
                '%s_%s_TYPICAL_%s.png', ...
                string(region), ...
                string(condition), ...
                R.SSN{typicalSession});

            filename = strrep(filename, ' ', '_');

            exportgraphics(fig, ...
                fullfile(saveDir, filename), ...
                'Resolution', 300);

            close(fig);

        else
            warning('Could not find session folder: %s', fd);
        end


        %% High UMAP
        fd = fullfile(baseDir, ...
            R.Rat{highSession}, ...
            R.SSN{highSession});

        if isfolder(fd)

            sd = TaskInit(fd);

            manifoldOutline = session_to_umap(sd, region);

            fig = ManifoldPlot(sd, manifoldOutline, condition);

            sgtitle(sprintf( ...
                '%s | %s | HIGH | %s | Z = %.2f', ...
                string(region), ...
                string(condition), ...
                R.SSN{highSession}, ...
                highZ));

            filename = sprintf( ...
                '%s_%s_HIGH_%s.png', ...
                string(region), ...
                string(condition), ...
                R.SSN{highSession});

            filename = strrep(filename, ' ', '_');

            exportgraphics(fig, ...
                fullfile(saveDir, filename), ...
                'Resolution', 300);

            close(fig);

        else
            warning('Could not find session folder: %s', fd);
        end

    end
end

end