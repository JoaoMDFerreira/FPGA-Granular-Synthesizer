
Fs=48000;

L=48000*0.1;
t=linspace(0,1,L);
input=32767*sin(2*pi*t*10000);

%%testbench test
% for type = 0:3
%     res=64;
%     for freq = 0:127
%         for i = 1:48
%             andrew_filter(input(i),freq,res,type);
%         end
%     end
%     freq=64;
%     for res = 0:127
%         for i = 1:48
%             andrew_filter(input(i),freq,res,type);
%         end
%     end
% end



input = 32767*(randn(1,L)-.5);

figure(1)
plot(t,input)

output = zeros(L);

figure(2)

subplot(6,1,1)
Y = fft(input);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
semilogx(f,10*log10(P1/32767))
title("Input")
xlabel("f (Hz)")
ylabel("|P1(f)|")
grid on;

res=64;
%%%%%%%%%%%%%%%%%%%%%%%% LPF %%%%%%%%%%%%%%%%%%%%%%%
CC = 0;
type = 0;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     
     subplot(6,5,6)
     semilogx(f,10*log10(P1/32767))
     title("LP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
CC = 32;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,11)
     semilogx(f,10*log10(P1/32767))
     title("LP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
CC = 64;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,16)
     semilogx(f,10*log10(P1/32767))
     title("LP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;     
     
CC = 96;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,21)
     semilogx(f,10*log10(P1/32767))
     title("LP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|") 
     grid on;
     
CC = 127;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,26)
     semilogx(f,10*log10(P1/32767))
     title("LP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
%%%%%%%%%%%%%%%%%%%%%%%% HPF %%%%%%%%%%%%%%%%%%%%%%%
CC = 0;
type = 1;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     
     subplot(6,5,6+type)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
CC = 32;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,11+type)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;

CC = 64;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,16+type)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
CC = 96;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,21+type)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|") 
     grid on;
     
CC = 127;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,26+type)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
%%%%%%%%%%%%%%%%%%%%%%%% BPF %%%%%%%%%%%%%%%%%%%%%%%
CC = 0;
type = 2;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     
     subplot(6,5,6+type)
     semilogx(f,10*log10(P1/32767))
     title("BP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
CC = 32;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,11+type)
     semilogx(f,10*log10(P1/32767))
     title("BP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;

CC = 64;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,16+type)
     semilogx(f,10*log10(P1/32767))
     title("BP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
CC = 96;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,21+type)
     semilogx(f,10*log10(P1/32767))
     title("BP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|") 
     grid on;
     
CC = 127;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,26+type)
     semilogx(f,10*log10(P1/32767))
     title("BP output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
     
%%%%%%%%%%%%%%%%%%%%%%%% BRF %%%%%%%%%%%%%%%%%%%%%%%
CC = 0;
type = 3;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     
     subplot(6,5,6+type)
     semilogx(f,10*log10(P1/32767))
     title("BR output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
CC = 32;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,11+type)
     semilogx(f,10*log10(P1/32767))
     title("BR output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;

CC = 64;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,16+type)
     semilogx(f,10*log10(P1/32767))
     title("BR output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
CC = 96;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,21+type)
     semilogx(f,10*log10(P1/32767))
     title("BR output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on; 
     
CC = 127;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,26+type)
     semilogx(f,10*log10(P1/32767))
     title("BR output with CC = " + CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;

     
%%%%%%%%%%%%%%%%%%%%%%%% RES test%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CC = 96;
type = 1;
res_CC = 0;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res_CC,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     
     subplot(6,5,10)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC + " and res = " + res_CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
res_CC = 32;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res_CC,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,15)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC + " and res = " + res_CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;

res_CC = 64;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res_CC,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,20)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC + " and res = " + res_CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;
     
res_CC = 96;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res_CC,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,25)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC + " and res = " + res_CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|") 
     grid on;
     
res_CC = 127;
 for i = 1:L
    output(i) = andrew_filter(input(i),CC,res_CC,type);
 end
  
     Y_F = fft(output);
     P2 = abs(Y_F/L);
     P1 = P2(1:L/2+1);
     P1(2:end-1) = 2*P1(2:end-1);
     f = Fs*(0:(L/2))/L;
     
     subplot(6,5,30)
     semilogx(f,10*log10(P1/32767))
     title("HP output with CC = " + CC + " and res = " + res_CC)
     xlabel("f (Hz)")
     ylabel("|P1(f)|")
     grid on;

 