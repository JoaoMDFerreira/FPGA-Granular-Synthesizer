
Fs=48000;
MAX_TIME_SECONDS=1;
size = Fs/MAX_TIME_SECONDS;

for size = 1:1000:size
%size = 10;
    %figure(size)
    %hold on
    t = linspace(0,size/48000,size);
    sine = 32767*sin(2*pi*100*t);
    
    window = zeros(1,size);
            
    for attack = 0:10:127    
        for i = 1:size
            window(i) = window_v3(attack,attack,i,size,sine(i));
        end
        
        %plot(t,window)
    end
    
    %hold off
end
