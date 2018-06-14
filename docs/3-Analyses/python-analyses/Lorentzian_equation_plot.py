import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider, Button, RadioButtons

fig, ax = plt.subplots()
plt.subplots_adjust(left=0.2, bottom=0.4)

""" Set initial values and frequency range """
f = np.arange(700, 2000, 1)
theta = 0
a0 = 10
f0 = 700
gamma = 10

""" Lorentzian equation from Labactor """
lorentzian_complex = (a0 * np.exp(1j * theta)) / (f - f0 + (1j * gamma))

""" Plots the real and imaginary parts and legend"""
l, = plt.plot(f, lorentzian_complex.imag, lw=2, color='red', label='Complex part')
m, = plt.plot(f, lorentzian_complex.real, lw=2, color='blue', label='Real part')
# plt.autoscale(enable=True)
ax.legend()

""" Defines coordinates and colors for the sliders """
axcolor = 'lightgoldenrodyellow'
axa0 = plt.axes([0.2, 0.13, 0.7, 0.03], facecolor=axcolor)
axf0 = plt.axes([0.2, 0.18, 0.7, 0.03], facecolor=axcolor)
axtheta = plt.axes([0.2, 0.23, 0.7, 0.03], facecolor=axcolor)
axgamma = plt.axes([0.2, 0.28, 0.7, 0.03], facecolor=axcolor)

""" Creates slider widgets with (axis, label, minVal, maxVal, initialVal) """
sf0 = Slider(axf0, 'f0', 0, 2000.0, valinit=f0)
sa0 = Slider(axa0, 'A', 0, 100, valinit=a0)
stheta = Slider(axtheta, 'Theta', 0, 2*np.pi, valinit=theta)
sgamma = Slider(axgamma, 'Gamma', 0, 300, valinit=gamma)

""" Updates the plot when the slider values are changed """
def update(val):
    """ Values from sliders """
    new_a0 = sa0.val
    new_f0 = sf0.val
    new_theta = stheta.val
    new_gamma = sgamma.val
    """ Equation with new values """
    lorentzian_complex = (new_a0 * np.exp(1j * new_theta)) / (f - new_f0 + (1j * new_gamma))
    """ Sets new values for y axis """
    l.set_ydata(lorentzian_complex.imag)
    m.set_ydata(lorentzian_complex.real)
    """ Autoscales axis """
    ax.relim()
    ax.autoscale_view()
    fig.canvas.draw_idle()
sf0.on_changed(update)
sa0.on_changed(update)
stheta.on_changed(update)
sgamma.on_changed(update)

""" Reset button location and widget """
resetax = plt.axes([0.8, 0.05, 0.1, 0.04])
button = Button(resetax, 'Reset', color=axcolor, hovercolor='0.975')

""" Resets slider values when button is pushed """
def reset(event):
    sf0.reset()
    sa0.reset()
    stheta.reset()
    sgamma.reset()
button.on_clicked(reset)

plt.show()
