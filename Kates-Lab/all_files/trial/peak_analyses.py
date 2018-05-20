"""
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
"""

"""
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
"""


import matplotlib as mpl
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import subprocess

#       --- Get/Clean Data  ---

def get_files(directory='.'):
    '''
    Returns: 
        - list of csv files from a given directory
    Parameters:
        - Directory: specifies the directory with the files you would like to analyze.
            - By Defualt: this method will use the current directory.
    '''
    
    # use shell command to get file list
    str_files  = subprocess.check_output(["ls "+directory+" | grep '\.csv$'"],shell=True).decode("utf-8")
    list_files = str_files.split("\n")
    
    # remove empty list elements
    while '' in list_files: list_files.remove('')  
        
    return list_files

def get_headers(file_name, signal_x_ind, signal_y_ind, peak_x_ind, peak_y_ind):
    '''
    PARAMETERS:
        - pass in a file, and the indices of the repective data
    RETURNS:
        - signal and peak labels for the data being used
    '''
    df = pd.read_csv(file_name)
    headers = list(df)
    
    signal_headers = [headers[signal_x_ind]] + [headers[signal_y_ind]]
    peak_headers   = [headers[peak_x_ind]]   + [headers[peak_y_ind]]

    return signal_headers, peak_headers

def convert(val):
    '''
    DESCRIPTION:
        - converts a string into a float.
        - You can use pandas to run this function over specific columns
          in your data, using, "df.apply_map(func)"
        - This is a helper function for store_file_data
    '''
    
    # conversion dictionary
    conversions = {
                    'n':10**-9,
                    'u':10**-6,
                    'm':10**-3,
                    'k':10**3,  
                    'M':10**6
                  }
    
    # get the last character in a value
    str_val   = str(val)
    last_char = str_val[-1]
    
    # convert last char it is in dictionary if it is in conversion list
    if last_char in conversions:
        val = float(str_val[:-1])*conversions[last_char]
    
    # implictely convert to float
    else:     
        try:
            val = float(val)
        except:
            print("Failed to Implicitely Convert to Float: ",val)
            return None
    
    return val

def store_file_data(file_names,signal_headers,peak_headers):
    '''
    DESCRIPTION:
        1. reads in all of the data, from all of the files
        2. parses all of the data
        3. splits the data into signal, and peak data, 
           that are stored in dataframes.
    RETURNS: dictionary:
        - KEY:   file_name
        - VALUE: (signal-DataFrame, peak-DataFrame)
    '''
    
    file_to_data = {}
    
    for read_file in file_names:
        
        # Read Data
        df = pd.read_csv(read_file)
           
        # Sepperate DataFrames
        df_signal  = df[list(df)[2:]]
        df_peak    = df[list(df)[:2]]
       
        # Drop Empty Rows
        df_signal = df_signal.dropna(axis=0) 
        df_peak   = df_peak.dropna(axis=0) 
        
        # Convert Data to Floats
        df_signal = df_signal.applymap(convert)
        df_peak = df_peak.applymap(convert)
        
        file_to_data[read_file] = (df_signal,df_peak)
    
    return file_to_data

def get_plot_data(file_name, all_data, signal_headers, peak_headers):
    '''
    RETURNS
        - the data from a single file that can than be plotted as 
          a tuple of arrays.
    '''

    # Signal to Plot
    df_signal = all_data[file_name][0]  
    x = df_signal[signal_headers[0]]
    y = df_signal[signal_headers[1]]
    
    # Peaks To Plot
    df_peak = all_data[file_name][1]
    x_peak  = df_peak[peak_headers[0]]
    y_peak  = df_peak[peak_headers[1]]
    
    return x,y,x_peak,y_peak

#       --- Build Graphs ---

def make_plots(all_data,signal_headers,peak_headers):
    '''
    DESCRIPTION:
        - Plots the data from all of the files one at a time.
        - These plots have clickable peaks. Everytime, a click is made on 
          a peak, the position of the peak is recorded. If the peak is 
          clicked on again, it will remove the record of that peak.
    RETURN:
        - returns a dictionary:
            - KEY: name of the file
            - VALUES: List of Tuples (x-coordinate, y-coordinate)
                      that describes the peaks that were clicked on. 
                      (if a peak is clicked again, it will be removed from 
                      this list.)
    '''
    
    important_peaks = {}

    for file_name in all_data:

        important_peaks[file_name] = []

        # Set Plot Size
        mpl.rcParams['figure.figsize'] = (11,7) 

        # Create Plot Figure/Axes
        fig, ax = plt.subplots()

        # Get Signal and Peak Data
        x, y, x_peak, y_peak = get_plot_data(file_name,all_data,signal_headers,peak_headers)

        # Set Axis Limits 
        # - (y-axis range is 20% greater than max data point in a plot)
        ax.set_xlim(0,1200000)
        ax.set_ylim(0,np.max(y_peak)+0.2*np.max(y_peak))

        ax.set_xlabel("Frequency")
        ax.set_ylabel("Magnitude")
        ax.set_title(file_name)

        # Peak Plot
        coll = ax.scatter(x_peak, y_peak, color=["blue"]*len(x_peak),picker=5,label="Peak Data")

        # Signal Plot
        ax.plot(x, y, linewidth=1, linestyle="-",
                 color="red", label="Magnitude vs. Frequency")

        print("File:",file_name)
        def on_pick(event):
            
            # index of the array, were the event occurred
            ind = event.ind[0]
            
            # where the event ocurred
            x_val = x_peak[ind]
            y_val = y_peak[ind]
            
            # add point
            if [x_val,y_val] not in important_peaks[file_name]:
            
                # color is speciified by: RGBA tuple
                # https://www.cgl.ucsf.edu/chimera/docs/ProgrammersGuide/Examples/footnotes/rgba.html
                important_peaks[file_name].append([x_val,y_val])
                coll._facecolors[ind,:] = (1, 0, 0, 1)
                coll._edgecolors[ind,:] = (1, 0, 0, 1)

                print("\t  Picked  Peak [ {:>3} ] at point: [ {:06.2f}, {:06.5f} ]".format(ind,x_val,y_val))
            
            # remove point
            else:
                
                important_peaks[file_name].remove([x_val,y_val])
                coll._facecolors[ind,:] = (0, 0, 1, 1)
                coll._edgecolors[ind,:] = (0, 0, 1, 1)

                print("\t  Removed Peak [ {:>3} ] at point: [ {:06.2f}, {:06.5f} ]".format(ind,x_val,y_val))
            
            fig.canvas.draw()

        ax.legend(loc="upper right")

        fig.canvas.mpl_connect('pick_event', on_pick)

        plt.show(block=True)

    return important_peaks

# 	--- Main Method  ---

def main():
    
    #       --- Get Data ---
    all_files = get_files()
    signal_headers, peak_headers = get_headers(all_files[0],2,3,0,1)
    all_data  = store_file_data(all_files,signal_headers,peak_headers)
    
    #       --- Make Plots ---
    important_peaks = make_plots(all_data,signal_headers,peak_headers)
    

if __name__ == "__main__":
    main()

