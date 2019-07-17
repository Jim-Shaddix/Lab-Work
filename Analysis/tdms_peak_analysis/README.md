
# Color
https://www.mathworks.com/matlabcentral/fileexchange/53862-matlab-schemer

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
1. Improve Lorentzian Fitting Algorithem
    - find a way to relate the width returned from the peaks to the lambda
      value in the lorentizan equation. This will improve guessing capabilities.
    - Try a bunch of different theta values, and see how strongly an initial 
      guess fits the data prior to running the fitting algorithem.
2. Improve Testing Capabilites:
    - build a gui that allows us to vary parameters and than replot the data.
        - In order to build the GUI, I will need to modify the plotting 
          script so that it can modularly apply functions to the data being
          plotted.
            - I will have to change the strings that are passed in, to identify
              when to apply functions to data.
            - I will need to change my functions, so that they can be applied
              to the magnitude data, or the raw data, or make sure that this
              is being handled when I pass in data into these functions.
    - Replicate Andrew's python script for interactive lorentzian plotting, and
      overlay plots, that way I can look for trends in where my fit is performing
      poorly. I can than record all of the actual fit values, and compare them
      to my fits, and see where things are most off. I would likely need some
      goodness of fit metric in order for this to work effectively.
3. See if I can graph the widths being returned, in order to see what they 
   look like.

## Things to Try: ##
We need to figure what the best way is to fit the data.
1. Try and find the peaks in the raw data, from the peaks that we find in the
   quadature data.

## Questions ##


## NOTEs ##
* [memory] (https://undocumentedmatlab.com/blog/internal-matlab-memory-optimizations)

