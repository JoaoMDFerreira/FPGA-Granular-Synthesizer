import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import rfft, rfftfreq

def zero_out(x,y):
    for n in range(x.size):
        if np.abs(x[n])>1:
            y[n] = 0

sample_rate = 96000
n = sample_rate*4
N=n

xf=rfftfreq(N, 1 / sample_rate)

x_n = np.linspace(-2,2,n)
y_n = np.sin(20*2*np.pi*x_n)

#plt.plot(x_n,y_n)
plt.subplot(3,2,1)
plt.title('Trapezoidal Envelope')
trapezoidal = np.minimum(np.abs(np.abs(x_n)*2-2),1)
zero_out(x_n,trapezoidal)
plt.plot(x_n,trapezoidal)
trapezoidal_y = trapezoidal*y_n
plt.plot(x_n,trapezoidal_y)
plt.xlim([-2,2])
plt.ylim([-1.1,1.1])
plt.xlabel('t')
plt.ylabel('A')
plt.subplot(3,2,2)
trapezoidal_fft = np.abs(rfft(trapezoidal_y))
plt.plot(xf, 20*np.log10(trapezoidal_fft/np.max(trapezoidal_fft)))
plt.grid()
plt.xscale('log')
plt.xlabel('f')
plt.ylabel('dB')
#plt.xlim([0,10**4])

plt.subplot(3,2,3)
plt.title('Gaussian Envelope')
gaussian = np.exp(-np.power((x_n)/(0.3),2))
zero_out(x_n,gaussian)
plt.plot(x_n,gaussian)
gaussian_y = gaussian*y_n
plt.plot(x_n,gaussian_y)
plt.xlim([-2,2])
plt.ylim([-1.1,1.1])
plt.xlabel('t')
plt.ylabel('A')
plt.subplot(3,2,4)
gaussian_fft = np.abs(rfft(gaussian_y))
plt.plot(xf, 20*np.log10(gaussian_fft/np.max(gaussian_fft)))
plt.grid()
plt.xscale('log')
plt.xlabel('f')
plt.ylabel('dB')
#plt.xlim([0,50])

plt.subplot(3,2,5)
plt.title('Parabolic Envelope')
parabolic = -np.power(x_n,2)+1
zero_out(x_n,parabolic)
plt.plot(x_n,parabolic)
parabolic_y = parabolic*y_n
plt.plot(x_n,parabolic_y)
plt.xlim([-2,2])
plt.ylim([-1.1,1.1])
plt.xlabel('t')
plt.ylabel('A')
plt.subplot(3,2,6)
parabolic_fft = np.abs(rfft(parabolic_y))
plt.plot(xf, 20*np.log10(parabolic_fft/np.max(parabolic_fft)))
plt.grid()
plt.xscale('log')
plt.xlabel('f')
plt.ylabel('dB')
plt.subplots_adjust(left=0.1,
                    bottom=0.1,
                    right=0.9,
                    top=0.9,
                    wspace=0.4,
                    hspace=0.4)
#plt.xlim([0,50])

plt.show(block=True)

