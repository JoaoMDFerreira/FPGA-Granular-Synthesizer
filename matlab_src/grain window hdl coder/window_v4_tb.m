
Fs=48000;
MAX_TIME_SECONDS=0.1;
size = Fs*MAX_TIME_SECONDS;



t = linspace(0,size/48000,size);
sine = 32767*sin(2*pi*100*t);

window = zeros(1,size);
            
for attack = 0:10:127
    for i = 1:size
        window(i) = window_v4(attack,attack,i,size,sine(i));
    end
end


%for attack = 0:32:127
%size = 10;
    figure(attack+1)
    t = linspace(0,size/48000,size);
    sine = 32767*sin(2*pi*100*t);
    
    window = zeros(1,size);
    
    attack = 0;
    for i = 1:size
        window(i) = window_v4(attack,attack,i,size,sine(i));
    end
    window_a = zeros(1,size);
    for i = 1:size
        window_a(i) = window_v4(attack,attack,i,size,32767);
    end
    subplot(3,1,1)
    hold on
    plot(t,window_a)
    plot(t,window)
    title('ASR window with attack and release of 0%')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('Sample number')
    legend('Window function','100Hz sine through Window')
    grid on;
    
    hold off
%end

    t = linspace(0,size/48000,size);
    sine = 32767*sin(2*pi*100*t);
    
    window = zeros(1,size);
    
    attack = 64;
    for i = 1:size
        window(i) = window_v4(attack,attack,i,size,sine(i));
    end
    window_a = zeros(1,size);
    for i = 1:size
        window_a(i) = window_v4(attack,attack,i,size,32767);
    end
    subplot(3,1,2)
    hold on
    plot(t,window_a)
    plot(t,window)
    title('ASR window with attack and release of 50%')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('Sample number')
    legend('Window function','100Hz sine through Window')
    grid on;
    
    hold off

    t = linspace(0,size/48000,size);
    sine = 32767*sin(2*pi*100*t);
    
    window = zeros(1,size);
    
    attack = 127;
    for i = 1:size
        window(i) = window_v4(attack,attack,i,size,sine(i));
    end
    window_a = zeros(1,size);
    for i = 1:size
        window_a(i) = window_v4(attack,attack,i,size,32767);
    end
    subplot(3,1,3)
    hold on
    plot(t,window_a)
    plot(t,window)
    title('ASR window with attack and release of 100%')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('t(s)')
    legend('Window function','100Hz sine through Window')
    grid on;
    
    hold off