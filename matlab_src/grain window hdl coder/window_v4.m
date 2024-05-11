

%CC_attack and CC_release are MIDI CC parameters which can vary between
%0-127 where 0=0% and 127=50%
function out = window_v4(CC_attack, CC_release,current,size,in)
    persistent interrim_1;
    if isempty(interrim_1)
        interrim_1 = 1;
    end
    persistent interrim_2;
    if isempty(interrim_2)
        interrim_2 = 1;
    end
    
    attack = floor((CC_attack)/255 *size)+1;
    release = floor((CC_release)/255 *size)+1;
    
    if current <= attack
        interrim_1 = (current-1) *in;
        out = interrim_1/attack;
    elseif current < size - release
        out = in;
    else
        %out = (size - current) /release *in;
        interrim_2 = (size-current) *in;
        out = interrim_2/release;
    end
end