import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import rfft, rfftfreq

def zero_out(x,y):
    for n in range(x.size):
        if np.abs(x[n])>1:
            y[n] = 0

sample_rate = 96000
n = sample_rate*20
N=n

xf=rfftfreq(N, 1 / sample_rate)

x_n = np.linspace(-2,2,n)
y_n = np.sin(20*2*np.pi*x_n)
operator_n = np.sin(1*2*np.pi*x_n)

plt.subplot(3,1,1)
plt.title('Signal (20Hz)')
plt.plot(x_n, y_n)
plt.ylim([-1.1,1.1])
plt.xlim([-1.1,1.1])
plt.xlabel('t(s)')
plt.ylabel('A')

plt.subplot(3,1,2)
plt.title('Operator (1Hz)')
plt.plot(x_n, operator_n)
plt.ylim([-1.1,1.1])
plt.xlim([-1.1,1.1])
plt.xlabel('t(s)')
plt.ylabel('A')

plt.subplot(3,1,3)
y_n = np.sin(20*2*np.pi*x_n*operator_n)
plt.title('FM Modulated Signal')
plt.plot(x_n, y_n)
plt.ylim([-1.1,1.1])
plt.xlim([-1.1,1.1])
plt.xlabel('t(s)')
plt.ylabel('A')



plt.subplots_adjust(left=0.1,
                    bottom=0.1,
                    right=0.9,
                    top=0.9,
                    wspace=0.4,
                    hspace=0.4)

#plt.xlim([-2,2])
plt.ylim([-1.1,1.1])
plt.xlabel('t(s)')
plt.ylabel('A')
plt.grid()
#plt.xlim([0,50])

plt.show(block=True)

