
%CC_attack and CC_release are MIDI CC parameters which can vary between
%0-127 where 0=0% and 127=50%
function ASR_OUT = ASR_GEN(ATTACK_CC, RELEASE_CC,MAX_ATTACK_MS,MAX_RELEASE_MS,CLK_FREQ,NOTE_ON,ASR_IN)
    % 0 => Idle; 1 => Attack; 2 => Sustain; 3 => Release
    persistent state;
    if isempty(state)
        state = 0;
    end
    
    persistent attack_ptr;
    if isempty(attack_ptr)
        attack_ptr = 0;
    end
    
    persistent release_ptr;
    if isempty(release_ptr)
        release_ptr = 0;
    end
    
    attack_clks  = floor(CLK_FREQ*MAX_ATTACK_MS/1000  *ATTACK_CC/128);
    release_clks = floor(CLK_FREQ*MAX_RELEASE_MS/1000 *RELEASE_CC/128);
    
    switch state
        case 0 %Idle state
            ASR_OUT = 0;
            if NOTE_ON == 1
                attack_ptr = 0;
                state = 1;
            end
            
        case 1 %Attack state
            if NOTE_ON == 1
                if attack_ptr >= attack_clks
                    state = 2;
                end
            else
                state = 3;
                release_ptr = attack_ptr;
            end
            if attack_clks == 0
                ASR_OUT = 0;
            else
                ASR_OUT = floor(attack_ptr/attack_clks *ASR_IN);
            end
            attack_ptr = attack_ptr + 1;
            
        case 2 %Sustain state
            ASR_OUT = ASR_IN;
            if NOTE_ON == 0
                state = 3;
                release_ptr = release_clks;
            end
            
        case 3 %Release state
            if NOTE_ON == 1 || release_ptr == 0
                state = 0;
            else
                release_ptr = release_ptr - 1;
            end
            if release_clks == 0
                ASR_OUT = 0;
            else
                ASR_OUT = floor(release_ptr/release_clks *ASR_IN);
            end
            
        otherwise
            ASR_OUT = 0;
            state = 0;
    end
end