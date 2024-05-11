

%%THIS FILE GENERATES THE LUT FOR THE FILTER CONVERSION BETWEEN MIDI CC AND
%%THE INTERNAL FREQUENCY THE FILTER UNDERSTANDS
fs = 48000; %sampling frequency

midi_note = linspace(0,127,128);
fc = 440.0*2.0.^((midi_note*1.05 - 69.0)/12.0); %real frequency - the *1.05 expands the filter to beyond 12k
filter_internal_freq = 2.0*sin(pi*min(0.25, fc/(fs*2)));

figure(1)
plot(midi_note,fc)

damp_freq  = min(2.0, 2.0./filter_internal_freq - filter_internal_freq.*0.5);
save('MIDI_CC_to_internal_freq.mat', 'filter_internal_freq','damp_freq');