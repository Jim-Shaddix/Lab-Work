# Files #
1. `main.m`: This is the main project file. This file calls all of the 
           functions I have developed, in order to visualize and track peaks.
2. `Make_Plots.m`: This file contains a function, that takes in a number of 
                 different arguments, in order to plot the data

# Directories #
1. **Fits**: Scripts for fitting all of the peaks in a dataset with a complex 
   Lorentzian function.
2. **Provided-MatlabScripts**: Scripts that were created by: ...
3. **Set_Peaks**: Scripts for finding peaks in a dataset.
4. **Store_TDMS_Data**: Scripts for storing information from tdms files, in
                      a modified format.
5. **scrollsubplot**: Third party code that I downloaded from [here](asdf).
This code is used to create large subplots. It generates subplots on a 
scrollable figure. (This is used instead of the `subplots` function, because
the subplots function will automitcally fit all the graphs created onto a 
single window, and the graphs come out very small if you end up generating alot of
them.) 
6. **figures**: Contains some interesting graphs that we generated.

## Things To Work On: ##
1. Merge changes from Andrews branch.
    - **NOTE:** I can't remember why if Andrew is able to run my current
            branch properly or not.
2. (**Needed**) Fix the plotting script, so that it plot the peaks that we 
   pick out. 
3. (**Needed**) Rewrite the fitting script, so that I have a file that just 
   has a single  function, for performing the fits. 
4. Find a way to make better fits of the peaks.
    1. I can try and recreate Andrew's script, and than make plots overit,
        this way I can better see where the program is failing.
    2. I can isolate particular regions, and try different methods for 
       approximating their values. (**I need to do this eventually**)
    3. it may also be useful to make peaks clickable. That way they can
       display their information, as well as the fitting information associated
       with them. (This may give me some indication as to what is going wrong.)
5. (**Needed**) Develop a method for finding peaks.

6. Make Subplots: [Clickable](https://www.mathworks.com/matlabcentral/answers/319493-how-to-click-the-subplots) 
