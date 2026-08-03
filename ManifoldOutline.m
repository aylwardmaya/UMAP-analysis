classdef ManifoldOutline
    properties
        E = [];
        rgb_colors = [];
        rgb_aligned = [];
        rgbTsd = [];
        n_bins = [];
        Q = [];
        Sreg = [];
        OZ = [];
        wzDelay = [];
        wzTsd = [];
        decisionTsd = [];
        valueTsd = [];
        OzoneData = [];
        WzoneData = [];
        NumNeighbors = [];
        NumDimensions = [];
    end

    methods
        function obj = ManifoldOutline(E, rgb_colors, rgb_aligned, rgbTsd, n_bins, Q, Sreg, ...
                OZ, wzDelay, wzTsd, decisionTsd, valueTsd, OzoneData, WzoneData, NumNeighbors, NumDimensions)
            obj.E = E;
            obj.rgb_colors = rgb_colors;
            obj.rgb_aligned = rgb_aligned;
            obj.rgbTsd = rgbTsd;
            obj.n_bins = n_bins;
            obj.Q = Q;
            obj.Sreg = Sreg;
            obj.OZ = OZ;
            obj.wzDelay = wzDelay;
            obj.wzTsd = wzTsd;
            obj.decisionTsd = decisionTsd;
            obj.valueTsd = valueTsd;
            obj.OzoneData = OzoneData;
            obj.WzoneData = WzoneData;
            obj.NumNeighbors = NumNeighbors;
            obj.NumDimensions = NumDimensions;
        end
    end
end