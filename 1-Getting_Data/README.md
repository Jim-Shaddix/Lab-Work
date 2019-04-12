

# Where We We Got The Files That We Analyzed #

## Hardware ##

### Vocabulary ###
1. [Red Pitaya](https://www.redpitaya.com/index2):
2. [transducers](https://en.wikipedia.org/wiki/Transducer): Things that convert
   one form of energy, into another form of energy.

1.) A **red pitaya** is connected to an **amplifier board**,
that is connected to a driving **transducers**. The other **transducer**
picks up the signal which goes through another **amplifier board** and
back to the Red Pitaya. The Red Pitaya interprets all of the info that we 
use to make plots, and sends this info to another computer to be processed.

2.) The transducers in this system contain crystals, that make use of the 
[piezoelectric-effect](http://www.nanomotion.com/piezo-ceramic-motor-technology/piezoelectric-effect/).
The **piezo-effect** is a reversible process in which certain materials generate
an electric charge, in response to some mechanical stress. The transducers in this
experiment were designed and built at Los Alamos National Laboratory.

3.) Measurements of the system are taken inside of a [ppms (physical property
measurement system)](https://www.qdusa.com/products/ppms.html). Which is capable
of temperatures as low as 1.8K and magnetic fields as high as 9 Tesla (90,000 gauss)

## Software ##
1.) **lab actor program:** Is used to interface with the **red pitaya**. Developed
by Los Alamos National Laboratories.

2.) **Comms Client program:** Allows remote control of Lab Actor through TCP. Developed
by Los Alamos National Laboratories.

3.) **Integrated Client** (Developed by: Andrews Sexton) Uses QD produced Labview VI's
alongside the Comms Client to remotely control the PPMS and LabActor simultaneously in
order to automate the process.


* RUS stands for: Resonant Ultrasonic Sprectroscopy.


