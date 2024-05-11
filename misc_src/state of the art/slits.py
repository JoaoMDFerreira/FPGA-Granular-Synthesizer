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


plt.subplot(4,1,1)
gaussian_0 = np.exp(-np.power((x_n+0.9)/(0.5),2))
plt.plot(x_n,gaussian_0)
gaussian_y_0 = gaussian_0*y_n
plt.plot(x_n,gaussian_y_0)
plt.ylim([-1.1,1.1])
plt.xlabel('t(s)')
plt.ylabel('A')
plt.title('1st Grain')
plt.grid()

plt.subplot(4,1,2)
gaussian_1 = np.exp(-np.power((x_n)/(0.5),2))
plt.plot(x_n,gaussian_1)
gaussian_y_1 = gaussian_1*y_n
plt.plot(x_n,gaussian_y_1)
plt.ylim([-1.1,1.1])
plt.xlabel('t(s)')
plt.ylabel('A')
plt.title('2nd Grain')
plt.grid()

plt.subplot(4,1,3)
gaussian_2 = np.exp(-np.power((x_n-0.9)/(0.5),2))
plt.plot(x_n,gaussian_2)
gaussian_y_2 = gaussian_2*y_n
plt.plot(x_n,gaussian_y_2)
plt.ylim([-1.1,1.1])
plt.xlabel('t(s)')
plt.ylabel('A')
plt.title('3rd Grain')
plt.grid()

plt.subplot(4,1,4)
gaussian_sum = gaussian_0 + gaussian_1 + gaussian_2
plt.plot(x_n,gaussian_sum)
gaussian_y_sum = gaussian_y_0 + gaussian_y_1 + gaussian_y_2
plt.plot(x_n,gaussian_y_sum)
plt.title('Sum')
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

