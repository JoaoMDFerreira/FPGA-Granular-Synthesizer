


length = 48000;
type = 0;


x = linspace(0,1,length);

window = window_gen(type, length);

y_0 = sin(2*pi.*x*10);
y_1 = y_0.*window;

figure(1)
subplot(2,1,1)
plot(x,y_0)
subplot(2,1,2)
hold on
plot(x,window,"black")
plot(x,y_1,"magenta")
legend('window','input','output')
hold off
