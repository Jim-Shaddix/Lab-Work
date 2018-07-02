# Files #
1. `main.m`: This is the main project file. This file calls all of the 
           functions I have developed, in order to visualize and track peaks.

# Directories #
1. **Fits**: Scripts for fitting all of the peaks in a dataset with a complex 
   Lorentzian function.
2. **Provided-MatlabScripts**: Scripts that were created by: ...
3. **Set_Peaks**: Scripts for finding peaks in a dataset.
4. **Store_TDMS_Data**: Scripts for storing information from tdms files, in
                      a modified format.
6. **figures**: Contains some interesting graphs that we generated.

## Things To Work On: ##
1. Merge changes from Andrews branch.
    - **NOTE:** I can't remember why if Andrew is able to run my current
            branch properly or not.
2. (**Needed**) Rewrite the fitting script, so that I have a file that just 
   has a single  function, for performing the fits. 
3. Find a way to make better fits of the peaks.
    1. I can try and recreate Andrew's script, and than make plots overit,
        this way I can better see where the program is failing.
    2. I can isolate particular regions, and try different methods for 
       approximating their values. (**I need to do this eventually**)
    3. it may also be useful to make peaks clickable. That way they can
       display their information, as well as the fitting information associated
       with them. (This may give me some indication as to what is going wrong.)
    4. I can come up stronger initial guesses, by making a bunch of initial 
       guesses and than, and than seeing which one of the initial guesses, 
       minimizes the mean squared error.
4. (**Needed**) Develop a method for finding peaks.
