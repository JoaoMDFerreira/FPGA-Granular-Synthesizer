

function window = window_v2(attack, release, grain_size,ROM)
    window = zeros(length(grain_size));
    
    ATTACK_N_POINTS = floor(grain_size*attack/100);
    RELEASE_N_POINTS = floor(grain_size*release/100);
    SUSTAIN_N_POINTS = grain_size - ATTACK_N_POINTS - RELEASE_N_POINTS;
    
    rom_ptr = 1;
    ROM_ATTACK_INCREMENT = floor(length(ROM)/ATTACK_N_POINTS);
    ROM_RELEASE_INCREMENT = floor(length(ROM)/RELEASE_N_POINTS);
    
    attack_done = 0;
    if SUSTAIN_N_POINTS ~= 0
        sustain_done = 0;
    else
        sustain_done = 1;
    end
    
    for i = 1:grain_size
        if attack_done == 0
            window(i) = ROM(rom_ptr);
            rom_ptr = rom_ptr + ROM_ATTACK_INCREMENT;
            if i==ATTACK_N_POINTS
                attack_done = 1;
            end
        elseif sustain_done == 0
            window(i) = 1;
            if i-ATTACK_N_POINTS == SUSTAIN_N_POINTS
                sustain_done = 1;
            end
        else
            rom_ptr = rom_ptr - ROM_RELEASE_INCREMENT ;
            window(i) = ROM(rom_ptr);
        end
    end
end

