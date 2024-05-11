
clear all

Fs=48000;
MAX_TIME_SECONDS=0.16;
size = Fs*MAX_TIME_SECONDS;

figure(1)

t = linspace(0,size/48000,size);
sine = 32767*sin(2*pi*100*t);

window = zeros(1,size);
envelope = zeros(1,size);

%%%%%%%%%%% attack=release=0 %%%%%%%%%%%
    subplot(3,2,1)
    attack = 0;
    ON = 1;
    for i = 1:size
        if i >= 4800
            ON = 0;
        end
        envelope(i) = ASR_GEN(attack,attack,100,100,Fs,ON,32767);
        window(i) = ASR_GEN(attack,attack,100,100,Fs,ON,sine(i));
    end
    
    hold on;
    plot(t,envelope)
    plot(t,window)
    hold off;
    
    title('ASR Envelope with an attack and release of 0')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('t(s)')
    legend('ASR Envelope','ASR Output (100Hz Sine Input)')
    grid on;

%%%%%%%%%%% attack=0 release=127 %%%%%%%%%%%
    subplot(3,2,2)
    attack = 0;
    release=127;
    ON = 1;
    for i = 1:size
        if i >= 4800
            ON = 0;
        end
        envelope(i) = ASR_GEN(attack,release,100,100,Fs,ON,32767);
        window(i) = ASR_GEN(attack,release,100,100,Fs,ON,sine(i));
    end
    
    hold on;
    plot(t,envelope)
    plot(t,window)
    hold off;
    
    title('ASR Envelope with an attack of 0 and a release of 127')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('t(s)')
    legend('ASR Envelope','ASR Output (100Hz Sine Input)')
    grid on;
    
    %%%%%%%%%%% attack=32 release=96 %%%%%%%%%%%
    subplot(3,2,3)
    attack = 32;
    release=96;
    ON = 1;
    for i = 1:size
        if i >= 4800
            ON = 0;
        end
        envelope(i) = ASR_GEN(attack,release,100,100,Fs,ON,32767);
        window(i) = ASR_GEN(attack,release,100,100,Fs,ON,sine(i));
    end
    
    hold on;
    plot(t,envelope)
    plot(t,window)
    hold off;
    
    title('ASR Envelope with an attack of 32 and a release of 96')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('t(s)')
    legend('ASR Envelope','ASR Output (100Hz Sine Input)')
    grid on;

    %%%%%%%%%%% attack=64 release=64 %%%%%%%%%%%
    subplot(3,2,4)
    attack = 64;
    release=64;
    ON = 1;
    for i = 1:size
        if i >= 4800
            ON = 0;
        end
        envelope(i) = ASR_GEN(attack,release,100,100,Fs,ON,32767);
        window(i) = ASR_GEN(attack,release,100,100,Fs,ON,sine(i));
    end
    
    hold on;
    plot(t,envelope)
    plot(t,window)
    hold off;
    
    title('ASR Envelope with an attack and release of 64')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('t(s)')
    legend('ASR Envelope','ASR Output (100Hz Sine Input)')
    grid on;
    
    %%%%%%%%%%% attack=127 release=127 %%%%%%%%%%%
    subplot(3,2,5)
    attack = 127;
    release=127;
    ON = 1;
    for i = 1:size
        if i >= 4800
            ON = 0;
        end
        envelope(i) = ASR_GEN(attack,release,100,100,Fs,ON,32767);
        window(i) = ASR_GEN(attack,release,100,100,Fs,ON,sine(i));
    end
    
    hold on;
    plot(t,envelope)
    plot(t,window)
    hold off;
    
    title('ASR Envelope with an attack and release of 127')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('t(s)')
    legend('ASR Envelope','ASR Output (100Hz Sine Input)')
    grid on;
    
    %%%%%%%%%%% attack=127 release=127 %%%%%%%%%%%
    subplot(3,2,6)
    attack = 127;
    release=127;
    ON = 1;
    for i = 1:size
        if i >= 1000
            ON = 0;
        end
        envelope(i) = ASR_GEN(attack,release,100,100,Fs,ON,32767);
        window(i) = ASR_GEN(attack,release,100,100,Fs,ON,sine(i));
    end
    
    hold on;
    plot(t,envelope)
    plot(t,window)
    hold off;
    
    title('ASR Envelope with an attack and release of 127')
    ylabel('Amplitude(signed 16-bit)')
    xlabel('t(s)')
    legend('ASR Envelope','ASR Output (100Hz Sine Input)')
    grid on;