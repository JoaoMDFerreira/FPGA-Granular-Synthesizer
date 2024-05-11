clear all
%%%%%%%%%%%%%%%%%%%%%% INITIAL VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs=48000;

%%MIDI_CC = 0 == fc=20 // MIDI_CC = 127 == fc=20k
FC_MAX = 20000;
FC_MIN = 20;
MIDI_MAX = 127;

MIDI_CC = linspace(0,127,128);

target_frequency = MIDI_CC*(FC_MAX-FC_MIN)/MIDI_MAX+FC_MIN;
filter_internal_freq = 2*sin(pi*min(0.25,target_frequency/(fs*2)));



figure(1)
subplot(2,2,1)
plot(MIDI_CC,target_frequency)
title('Target Frequency against MIDI CC')

subplot(2,2,2)
plot(MIDI_CC,filter_internal_freq)
title('Internal filter frequency against MIDI CC')


%%%%%%%%%%%%%%%%%%%%%% ADJUSTED VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%as can be seen by the time we target 5k freq MIDI_CC is already about 20,
%%a lot more finesse should be allowed below 1k especially

%%the way to solve this is to make the increase in filter_internal_freq
%%more gradual at the beggining 
%%this can be achieved by setting a target frequency for different MIDI_CC
%%values and searching for the curve which best fits it
%%
%%lets say that:
%% CC = 0    => f = 20
%% CC = 64   => f = 2k
%% CC = 127  => f = 20k
%%
%%lets attempt the following algorithms:
%% poly2 - decreases at the beggining  [NO]
%% poly3 - decreases at the beggining  [NO]
%% exp1  - not enough at the beggining [NO]
%% exp2  - weird behaviour             [NO]
%% fourier1  - decreases at the beggining  [NO]
%% fourier2  
%% gauss1 - 
%% gauss2
%% cubicinterp

x(1)=0;   f(1)=20;
x(2)=16;  f(2)=120;
x(3)=32;  f(3)=500;
x(4)=48;  f(4)=1000;
x(5)=64;  f(5)=2000;
x(6)=127; f(6)=20000;

%x(1)=0;   f(1)=20;
%x(2)=64;  f(2)=4000;
%x(3)=127; f(3)=20000;

clearvars fit;
subplot(2,2,3)
fit= fit(x',f','poly4');
plot(fit)
xlim([0 127])
title('Frequency Fitted Curve to MIDI CC')

x = MIDI_CC;
p1 = 0.0001213; p2 = -0.0114; p3 = 0.7464; p4 = -1.993; p5 = 16.33;
target_frequency = p1*x.^4 + p2*x.^3 + p3*x.^2 + p4*x + p5;

filter_internal_freq = 2*sin(pi*min(0.25,target_frequency/(fs*2)));

%%this array can be saved and used as a LUT
subplot(2,2,4)
plot(MIDI_CC,target_frequency)
%semilogy(MIDI_CC,target_frequency)
title('Polynomial fit of CC values to target frequencies (log scale)')
ylabel("f (Hz)")
xlabel("MIDI CC")
ylim([0,2e4])
grid on;

subplot(2,2,3)
semilogy(MIDI_CC,target_frequency)
title('Polynomial fit of CC values to target frequencies (linear scale)')
ylabel("f (Hz)")
xlabel("MIDI CC")
ylim([0,2e4])
grid on;



%save('MIDI_CC_to_internal_freq.mat', 'filter_internal_freq');

