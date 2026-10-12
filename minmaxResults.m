function [results, plot] = minmaxResults(R, sessionZ)

for iC = 1:length(sessionZ(1, 1, :)) % iterate through condition
    for iR = 1:length(sessionZ(1, :, 1)) % iterate through region
        maxZ = max(sessionZ(:, iR, iC));
        minZ = min(sessionZ(:, iR, iC));

        results = zeros(length(sessionZ(1, 1, :)), 2, 2);

        results(:, 1, 1) = R.SSN(find(maxZ)); % get SSN
        results(:, 2, 1) = maxZ; % save max z score
        results(:, 1, 2) = minZ; % save min z score
    end
end

    plot = minmaxPlot(R, sessionZ, results);

end