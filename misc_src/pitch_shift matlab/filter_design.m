
[input,fs] = audioread('C:\Users\Asurans\Desktop\Sound\Ongoing Projects\22-02-2023 Project\22-02-2023-1.wav');
input = input';

N = 10;        
Fs = 48e3;   
Fp = 20e3;      
Fst = 28e3;
Ap = 0.01;      
Ast = 80;

fs_input = 48e3;
%fs_input = fs;
time_length = 1;
time_step = 1/fs_input;
t_1 = 0:time_step:time_length-time_step;
Length = length(t_1);

 signal = sin(2*pi*20*t_1) + sin(2*pi*100*t_1) + sin(2*pi*500*t_1) + sin(2*pi*1000*t_1);
 signal = signal/max(signal);
 %signal = input(1,1:fs*time_length);

%plot input signal
figure(1)
subplot(7,1,1)
plot(t_1,signal)
title("Input Signal")
xlabel("t(s)")
ylabel("A")

%plot input signal FFT
subplot(7,1,2)
Y_in = fft(signal);
P2 = abs(Y_in/Length);
P1_in = P2(1:Length/2+1);
P1_in(2:end-1) = 2*P1_in(2:end-1);
f = fs_input*(0:(Length/2))/Length;
semilogx(f,20*log10(P1_in))
axis([20 2e4 -96 0])
title("Input FFT")
xlabel("f(Hz)")
ylabel("|P(f)|")


M=100;
L=80;
%make upsampled array
fs_upsample = L*fs_input;
upsampled_signal = zeros(1,Length*L);
for i = L:L:Length*L
    upsampled_signal(i) = signal(i/L);
end

subplot(7,1,3)
t_2=linspace(0,time_length*L,length(upsampled_signal));
plot(t_2,upsampled_signal)
title("Zero-Packed Signal (L=80)")
xlabel("t(s)")
ylabel("A")
%xlim([0 100/fs_input])
%ylim([-1 1])

%aliasing filter
fc = fs_upsample*0.5/M;

%%if decimation factor M/L>1 (M>L) then cutoff frequency corresponds to new
%%sample rate else the cutoff frequency corresponds to old sample rate https://www.dsprelated.com/showthread/comp.dsp/32181-2.php#tabs1-chronological
%%if you use the polyphase implementation, the computation requirements don't change as you change M and L. 
%%the number of coefficents increases with L

    N = 60;
    [n,fo,ao,w] = firpmord([fc fc*1.1],[1 0],[0.001 0.001],fs_upsample);
    b = firpm(n,fo,ao,w);
    %fvtool(b,1)

y = L*filter(b,1,upsampled_signal);

subplot(7,1,4)
t_3=0:1/fs_upsample:time_length-1/fs_upsample;
plot(t_3,y(:,1:length(t_3)))
title("Upsampled Signal at new f_s")
xlabel("t(s)")
ylabel("A")

%t = 0:time_step:time_length-time_step;

out = zeros(1,length(t_1));
%decimate
for i = 1:length(t_3)/M
    out(i) = y(i*M);
end

%     N = 50;
%     [n,fo,ao,w] = firpmord([20e3 22e3],[1 0],[0.001 0.001],fs_input);
%     b = firpm(n,fo,ao,w);
%     out = filter(b,1,out);
    

subplot(7,1,5)
plot(t_1,out(:,1:length(t_1)))
title("Pitch-shifted output at original f_{s}(decimated with M=100)")
xlabel("t(s)")
ylabel("A")

    
%plot output signal FFT
subplot(7,1,6)
Y_out = fft(out);
P2 = abs(Y_out/Length);
P1_out = P2(1:Length/2+1);
P1_out(2:end-1) = 2*P1_out(2:end-1);
f = fs_input*(0:(Length/2))/Length;
semilogx(f,20*log10(P1_out))
axis([20 2e4 -96 0])
title("Output FFT")
xlabel("f(Hz)")
ylabel("|P(f)|")

%plot both output and input at the same time
subplot(7,1,7)
f = fs_input*(0:(Length/2))/Length;
hold on;
semilogx(f,20*log10(P1_in))
semilogx(f,20*log10(P1_out))
hold off;
set(gca, 'XScale', 'log');
axis([20 2e4 -96 0])
title("Input vs Output FFT")
xlabel("f(Hz)")
ylabel("|P(f)|")


out = out';
player = audioplayer(out,fs);
play(player);


% filter_out = zeros(1,length(upsample_signal));
% for i = 1:length(upsampled_signal)
%    filter_out(i) = interpolation_filter(upsample_signal(i),fc); 
% end
