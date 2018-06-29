

# Analysis: #
The files in this directory are used to develop peak analyses algorithems.

## Directories ##

1. **Lorentzian:** Contains files that describe the complex Lorentzian function
               that is used by the lab-actor program.
2. **tdms_peak_analysis:** Contains files that are used to analyze the tdms files
                    that are produced by the lab actor program
3. **scroll_plot_clicker:** Contains a python script that creates interactive 
                      plots of all of the tdms files with there respective 
                      peaks. These peaks can be clicked on in order to toggle
                      whether or not they should be considered as significant 
                      peaks. All of the significant peak are than displayed
                      on singal comprehensive plot.
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
5. (**Needed**) Develop a method for finding peaks.

6. Make Subplots: [Clickable](https://www.mathworks.com/matlabcentral/answers/319493-how-to-click-the-subplots) 
