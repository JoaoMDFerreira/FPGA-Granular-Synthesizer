
%https://www.musicdsp.org/en/latest/Filters/92-state-variable-filter-double-sampled-stable.html
%https://www.mathworks.com/help/hdlcoder/ug/optimize-feedback-loop-design-and-maintain-high-data-precision-for-hdl-code-generation.html
function [y] = andrew_filter(in,MIDI_CC_FREQ,CC_RES,type) 
    persistent low;
    persistent band;
    if isempty(low)
        low = 0;
    end
    if isempty(band)
        band = 0;
    end
    
    loaded = coder.load('MIDI_CC_to_internal_freq.mat');
    filter_internal_freq = loaded.filter_internal_freq; %%check LUT_from_MIDI_Note.m
    damp_freq = loaded.damp_freq;
    
    freq = filter_internal_freq(MIDI_CC_FREQ+1);
    
    res = CC_RES/127.0;
    
    damp=min(2.0*(1.0 -res*2^-2), damp_freq(MIDI_CC_FREQ+1));
    
    notch = in - damp*band;
    low   = low + freq*band;
    high  = notch - low;
    band  = freq*high + band;
    switch type
        case 1
            out = 0.5*high;
        case 3
            out = 0.5*notch;
        case 2
            out = 0.5*band;
        otherwise
            out = 0.5*low;            
    end
    notch = in - damp*band;
    low   = low + freq*band;
    high  = notch - low;
    band  = freq*high + band;
    switch type
        case 1
            y = out + 0.5*high;
        case 3
            y = out + 0.5*notch;
        case 2
            y = out + 0.5*band;
        otherwise
            y = out + 0.5*low;
    end

    y = floor(y);
end
