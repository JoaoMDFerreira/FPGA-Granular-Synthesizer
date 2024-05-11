
[input,fs] = audioread('F:\Music\complete\MARINA_Electra Heart_09_Teen Idle.flac');
input = input';

fs_input = fs;
time_length = 30;
time_step = 1/fs_input;
t = 0:time_step:time_length-time_step;
Length = length(t);

signal = input(1,1:fs*time_length);

%plot input signal
figure(1)
subplot(7,1,1)
plot(t,signal)
title("Input Signal")

%plot input signal FFT
subplot(7,1,2)
Y_in = fft(signal);
P2 = abs(Y_in/Length);
P1_in = P2(1:Length/2+1);
P1_in(2:end-1) = 2*P1_in(2:end-1);
f = fs_input*(0:(Length/2))/Length;
semilogx(f,20*log10(P1_in))
xlim([20 30e3])
title("Input FFT")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%Pitch relation = L/M
M=40;
L=80;
%make upsampled array
upsampled_signal = zeros(1,Length*L);
for i = L:L:Length*L
    upsampled_signal(i) = signal(i/L);
end

subplot(7,1,3)
t=linspace(0,time_length*L,length(upsampled_signal));
plot(t,upsampled_signal)
title("Upsampled Signal at original fs")
%xlim([0 100/fs_input])
%ylim([-1 1])

subplot(7,1,4)
fs_upsample = L*fs_input;
t=0:1/fs_upsample:time_length-1/fs_upsample;
plot(t,upsampled_signal(:,1:length(t)))
title("Upsampled Signal at new fs")
    
%%if decimation factor M/L>1 (M>L) then cutoff frequency corresponds to new
%%sample rate else the cutoff frequency corresponds to old sample rate https://www.dsprelated.com/showthread/comp.dsp/32181-2.php#tabs1-chronological
%%if you use the polyphase implementation, the computation requirements don't change as you change M and L. 
%%the number of coefficents increases with L

%%my current working theoryis that designing a working filter for original
%%fs/2

fc = fs_input*0.5;
N = 50;
[n,fo,ao,w] = firpmord([fs_input*0.5 fc*1.4],[1 0],[0.001 0.001],fs_input);
b = firpm(n,fo,ao,w);
%fvtool(b,1)

y = L*filter(b,1,upsampled_signal);
subplot(7,1,5)
plot(t,y(:,1:length(t)))
title("Pitch shifted output at original fs")


out = zeros(1,length(t));
%decimate
for i = 1:length(t)/M
    out(i) = y(i*M);
end

    N = 50;
    [n,fo,ao,w] = firpmord([20e3 22e3],[1 0],[0.001 0.001],fs_input);
    b = firpm(n,fo,ao,w);
    out = filter(b,1,out);
    
%plot output signal FFT
subplot(7,1,6)
Y_out = fft(out);
P2 = abs(Y_out/Length);
P1_out = P2(1:Length/2+1);
P1_out(2:end-1) = 2*P1_out(2:end-1);
f = fs_input*(0:(Length/2))/Length;
semilogx(f,20*log10(P1_out))
xlim([20 30e3])
title("Output FFT")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%plot both output and input at the same time
subplot(7,1,7)
f = fs_input*(0:(Length/2))/Length;
hold on
semilogx(f,20*log10(P1_in))
semilogx(f,20*log10(P1_out))
hold off
xlim([20 30e3])
title("Input vs Output FFT")
xlabel("f (Hz)")
ylabel("|P1(f)|")


out = out';
player = audioplayer(out,fs);
play(player);


% filter_out = zeros(1,length(upsample_signal));
% for i = 1:length(upsampled_signal)
%    filter_out(i) = interpolation_filter(upsample_signal(i),fc); 
% end
