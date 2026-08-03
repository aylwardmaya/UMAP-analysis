function [wzDelay, wzTsd] = waitzone(sd)
    wzDelay = RR_WaitDelayTsd(sd);
    zones = RR_FindZone(sd, sd.x.time);
    wzTsd = tsd(sd.x.time, zones);
    isWZ = ismember(wzTsd.data, [1 2 3 4]);
    wzTsd.D(~isWZ) = nan;
end