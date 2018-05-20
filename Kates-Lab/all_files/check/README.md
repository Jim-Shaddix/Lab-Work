README.md: 

    # peak_analyses.py
    ~~~~~~~~~~~~~~~~~~

    ## Purpose
    This script was written for an experiment that is being conducted by 
    Dr. Kate Ross, at Colorado State University. 
   
    ## What This Script Does 
    This script makes plots of all of the csv files in a given
    directory. All of the csv files contain both signal, and peak data.
    This script will incrementally plot the data in each csv file. (In
    the case of Dr. Ross's experiment, I made plots of Voltage vs Frequency)
        * Each plot is interactive, and allows for the user to click on a 
          specific peak. 
        * When a peak is clicked, the position of the peak is 
          recorded. 
        * If the same peak is clicked again, it will no longer be recorded.
        * When a user is done picking all of the significant peaks in a
          graph, they need to close the graph, for the script to continue
          running.
        * After all of the plots have been closed, a composite plot is 
          created that graphs the x-coordinates from the peaks that were
          clicked on, vs another variable. (In the case of this experiment,
          a Frequency vs. Temperature plot is created.)

    ## How To Use
        * This script requires python 3.x to run
        * This script uses a few arguments to specify how it will run, however
          default arguements exist for all available options.
            - **directory**: specifes the directory that contains all of the 
              csv files to be analyzed. 
            - **signal_x_ind:** specifies the column position in the csv file
              that contains the x coordinates for the signal data.
            - **signal_y_ind:** specifies the column position in the csv file
              that contains the y coordinates for the signal data.
            - **peak_x_ind:** specifies the column position in the csv file
              that contains the x coordinates for the signal data.
            - **signal_x_ind:** specifies the column position in the csv file
              that contains the x coordinates for the signal data.

    Author: James Shaddix
    Email:  jimmy.shaddix2.0@gmail.com

