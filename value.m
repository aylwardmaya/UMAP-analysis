function valueTsd = value(sd)
    threshold = RR_BehaviorThresholds(sd, "perRestaurant", true);
    OZ = RR_OfferDelayTsd(sd);

    zoneMatrix = OZ.zone.D;
    % zoneMatrix(isnan(zoneMatrix)) = 0;
    offerDelay = OZ.delay.D;
    % offerDelay(isnan(offerDelay)) = 0;

    valueMatrix = nan(size(zoneMatrix)); % Initialize valueMatrix
        R1 = (zoneMatrix == 1);
        R2 = (zoneMatrix == 2);
        R3 = (zoneMatrix == 3);
        R4 = (zoneMatrix == 4);

    valueMatrix(R1) = threshold(1) - offerDelay(R1);
    valueMatrix(R2) = threshold(2) - offerDelay(R2);
    valueMatrix(R3) = threshold(3) - offerDelay(R3);
    valueMatrix(R4) = threshold(4) - offerDelay(R4);
    

    valueTsd = tsd(OZ.delay.time, valueMatrix);

end