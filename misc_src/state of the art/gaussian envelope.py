import numpy as np
import matplotlib.pyplot as plt

n = 4096

x_n = np.linspace(-2,2,n)
y_n = np.sin(20*x_n)

#plt.plot(x_n,y_n)

envelope = np.exp(-np.power(x_n,2))

#plt.plot(x_n,envelope)

y_n = envelope*y_n

plt.plot(x_n,y_n)

plt.xlabel('t')
plt.ylabel('A')
plt.show(block=True)

