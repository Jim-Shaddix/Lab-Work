## Directories ##
1. **scrollsubplot**: Third party code that I downloaded from [here](asdf).
This code is used to create large subplots. It generates subplots on a 
scrollable figure. (This is used instead of the `subplots` function, because
the subplots function will automitcally fit all the graphs created onto a 
single window, and the graphs come out very small if you end up generating alot of
them.) 

## Files ##
2. **Make_Plots.m**: Contains a function, that takes in a number of 
                 different arguments, in order to plot various data sets 
                 from each of tdms_datasets passed in.
2. **Plot_File.m**: Contains a function that makes a plot of a particular 
               dataset passed in.
3. **Pop_Up_Plot.m**: This function is called on when a graph in one of the subplots that
   is generated from the make plots function is pressed on. This function will
   generate a replica graph that is larger, and that can be further analyzed.
