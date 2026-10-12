classdef umapDistribution < ADRLABW_BaseData

    properties
        conditions;
        Sreg;

        % analysis outputs
        p;
        results;
        session;
    end

    methods
        function R = umapDistribution(fc, varargin) % constructor
            R@ADRLABW_BaseData(fc, varargin{:});

            R.Sreg = {'LO', 'VO', 'HC'};
            R.conditions = {"time", "offer delay", "offer zone", "wait zone", ...
                "wait zone countdown", "decision", "value", "track"};

            R.p = cell(R.nS, length(R.Sreg), length(R.conditions));
            R.results = cell(R.nS, length(R.Sreg), length(R.conditions));

            R.Rat = cell(R.nS, 1); % cell array not strings
            R.session = R.SSN;
        end

        function Go(R, starting_iS)
            arguments
                R;
                starting_iS = 1;
            end

            hW = waitbar(0, 'UMAP analysis');
            t = nan(R.nS, 1);

            for iS = starting_iS:R.nS
                tic;
                try
                    sd = TaskInit(R.fc{iS});
                    figure(hW);
                    waitbar(iS/R.nS, hW, sprintf('%d/%d: %s (%.0f s remaining)', ...
                        iS, R.nS, sd.ExpKeys.SSN, (1 + R.nS - iS) * mean(t, 'omitnan')));

                    R.UpdateOneSession(iS, sd);
                    R.ProcessOneSession(iS, sd);
                catch E
                    warning('umapDistribution: SessionFailed', 'Session %d failed: %s,', ...
                        iS, E.message);
                end
                save umap_temp.mat R;

                t(iS) = toc;
            end
            delete(hW);
        end

        function ProcessOneSession(R, iS, sd)

            for iR = 1:length(R.Sreg)
                Sreg = R.Sreg{iR};
                try
                    manifold = session_to_umap(sd, Sreg);
                catch E
                   warning('Could not build %s manifold for %s: %s', ...
                       Sreg, sd.ExpKeys.SSN, E.message);
                continue
                end

            for iC = 1:length(R.conditions)
                condition = R.conditions{iC};
                fprintf('Analyzing %s - %s...\n', Sreg, condition);

                try 
                    [p_session, result] = analysis(manifold, condition);
                    R.p{iS, iR, iC} = p_session;
                    R.results{iS, iR, iC} = result;
                catch E
                    warning('Analysis failed for %s - %s: %s', Sreg, condition, E.message);
                    R.p{iS, iR, iC} = nan;
                    R.results{iS, iR, iC} = [];
                end
            end
            end

        end
        
        function data = getCondition(R, Sreg, condition)
            iR = find(strcmp(R.Sreg, Sreg), 1);
            iC = find(strcmp(R.conditions, condition), 1);
            
            data.p = R.p(:, iR, iC);
            data.results = R.results(:, iR, iC);

            data.session = R.SSN;
            data.Sreg = Sreg;
            data.condition = condition;
        end
    end
end
