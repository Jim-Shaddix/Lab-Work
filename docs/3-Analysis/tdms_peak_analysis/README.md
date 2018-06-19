

# Files #
1. `main.m`: This is the main project file. This file calls all of the 
           functions I have developed, in order to visualize and track peaks.
2. `Make_Plots.m`: This file contains a function, that takes in a number of 
                 different arguemnts, in order to plot the data

# Directories #
1. `Fits`: Scripts for fitting all of the peaks in a dataset with a complex 
   Lorentzian function.
2. `Provided-MatlabScripts`: Scripts that were created by: ...
3. `Set_Peaks`: Scripts for finding peaks in a dataset.
4. `Store_TDMS_Data`: Scripts for storing information from tdms files, in
                      a modified format.
5. `scrollsubplot`: Third party code that I downloaded from [here](asdf).
This code is used to create large subplots. It generates subplots on a 
scrollable figure. (This is used instead of the `subplots` function, because
the subplots function will automitcally fit all the graphs created onto a 
single window, and the graphs come out very small if you end up generating alot of
them.) 
6. `figures`: Contains some interesting graphs that we generated.
