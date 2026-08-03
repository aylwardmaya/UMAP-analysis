function [OzoneData, WzoneData] = getzones(sd)

zones = RR_FindZone(sd, sd.x.time);

zone1Tsd = tsd(sd.x.time, zones);
zone1 = ismember(zone1Tsd.data, 1);
zone1Tsd.D(~zone1) = nan;

zone2Tsd = tsd(sd.x.time, zones);
zone2 = ismember(zone2Tsd.data, 2);
zone2Tsd.D(~zone2) = nan;

zone3Tsd = tsd(sd.x.time, zones);
zone3 = ismember(zone3Tsd.data, 3);
zone3Tsd.D(~zone3) = nan;

zone4Tsd = tsd(sd.x.time, zones);
zone4 = ismember(zone4Tsd.data, 4);
zone4Tsd.D(~zone4) = nan;

zone5Tsd = tsd(sd.x.time, zones);
zone5 = ismember(zone5Tsd.data, 5);
zone5Tsd.D(~zone5) = nan;

zone6Tsd = tsd(sd.x.time, zones);
zone6 = ismember(zone6Tsd.data, 6);
zone6Tsd.D(~zone6) = nan;

zone7Tsd = tsd(sd.x.time, zones);
zone7 = ismember(zone7Tsd.data, 7);
zone7Tsd.D(~zone7) = nan;

zone8Tsd = tsd(sd.x.time, zones);
zone8 = ismember(zone8Tsd.data, 8);
zone8Tsd.D(~zone8) = nan;

OzoneData = struct('zone5Tsd', zone5Tsd, 'zone6Tsd', zone6Tsd, ...
    'zone7Tsd', zone7Tsd, 'zone8Tsd', zone8Tsd);

WzoneData = struct('zone1Tsd', zone1Tsd, 'zone2Tsd', zone2Tsd, ...
    'zone3Tsd', zone3Tsd, 'zone4Tsd', zone4Tsd);

end