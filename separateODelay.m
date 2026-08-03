function [aTsd,bTsd] = separateODelay(sd)
    threshold = RR_BehaviorThresholds(sd, "perRestaurant", true);
    OZ = RR_OfferDelayTsd(sd);

    zoneMatrix = OZ.zone.D;
    offerDelay = OZ.delay.D;


    a = nan(size(zoneMatrix)); % Initialize above threshold values
        R1 = (zoneMatrix == 1);
        R2 = (zoneMatrix == 2);
        R3 = (zoneMatrix == 3);
        R4 = (zoneMatrix == 4);

    b = nan(size(zoneMatrix)); % Initialize below threshold values
        R1 = (zoneMatrix == 1);
        R2 = (zoneMatrix == 2);
        R3 = (zoneMatrix == 3);
        R4 = (zoneMatrix == 4);

    a(R1) = threshold(1) < offerDelay(R1);
    a(R2) = threshold(2) < offerDelay(R2);
    a(R3) = threshold(3) < offerDelay(R3);
    a(R4) = threshold(4) < offerDelay(R4);

    b(R1) = threshold(1) >= offerDelay(R1);
    b(R2) = threshold(2) >= offerDelay(R2);
    b(R3) = threshold(3) >= offerDelay(R3);
    b(R4) = threshold(4) >= offerDelay(R4);
ery
    aTsd = tsd(OZ.delay.time, a);
    bTsd = tsd(OZ.delay.time, b);
end