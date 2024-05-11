MAX_GRAIN_SIZE = 0.1; %in seconds
fs = 48000;

MAX_GRAIN_SIZE_SAMPLE = fs*MAX_GRAIN_SIZE;
%the max size the slope can have is 50% of MAX_GRAIN_SIZE
ROM_SIZE = round(MAX_GRAIN_SIZE_SAMPLE*10);

ROM = linspace(0,1,ROM_SIZE);

%grain size is given in points, for a 100ms grain_size (a possible maximum)
%the grain size is given by fs*t, 48k*0.1=4800 samples
grain_size = fs*MAX_GRAIN_SIZE;


figure(1)
hold on
for i = 1:1:50
    window = window_v2(i, i, MAX_GRAIN_SIZE_SAMPLE,ROM);
    t = linspace(0,1,MAX_GRAIN_SIZE_SAMPLE);
    plot(t,window)
end
%plot(t,sin(2*pi*t*10).*window);






