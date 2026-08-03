function [decisionTsd] = decision(sd)
    offerTime = sd.TD.behav.offerTime;
    decision = RR_OfferDecision(sd, offerTime);

    transformDecision = nan(size(decision));

    transformDecision(strcmp(decision, 'quit'))   = 0;
    transformDecision(strcmp(decision, 'skip'))   = 1;
    transformDecision(strcmp(decision, 'accept')) = 2;

    decisionTsd = tsd(offerTime, transformDecision);
end