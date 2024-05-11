

%CC_attack and CC_release are MIDI CC parameters which can vary between
%0-127 where 0=0% and 127=50%
function out = window_v3(CC_attack, CC_release,current,size,in)
    attack = floor((CC_attack+1)/255 *size)+1;
    release = floor((CC_release+1)/255 *size)+1;
    sustain = size - attack - release;
    
    if current <= attack
        out = (current-1)/attack *in;
    elseif current < attack + sustain
        out = in;
    else
        out = (1 - (current - attack - sustain)/release) *in;
    end
end