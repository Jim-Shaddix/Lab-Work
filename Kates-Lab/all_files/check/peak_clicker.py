import matplotlib as mpl
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import subprocess

from PointClickGraph import Point_Click_Graph

#      --- Getting Data For Point_Click_Plot Class ---
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

def convert(val):
    '''
    DESCRIPTION:
        - converts a string into a float.
        - this function is passed into the Point_Click_Graph constructor
        - this function will be called on every data point in the data
          that is being analyzed by Point_Click_Graph
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

#      --- Functions For Final Plot ---
def get_temps(dict_imp_peaks):
    '''
    DESCRIPTION:
        * This method returns temperature data by parsing it from the files
        that are used.
        * This method is subject to change, if the file names are changed in the future.
    '''
    
    Temp = []
    for file_name in dict_imp_peaks:
        for peak in dict_imp_peaks[file_name]:
            Temp.append(float(file_name.split('_')[4][:-1]))
            
    return Temp
    
def important_peak_plot(dict_imp_peaks):
    '''
    DESCRIPTION:
        * Generates a composite plot, from all of the peaks that were clicked
        * Frequency vs. Temperature
    '''
    # get temperatures and frequencies to plot
    Temp  = get_temps(dict_imp_peaks)
    Freq  = []
    for file_name in dict_imp_peaks:
        for peak in dict_imp_peaks[file_name]:
            Freq.append(peak[0])

    # create plot
    fig = plt.figure()

    plt.plot(Temp,Freq,"o", 
             markeredgewidth=2,markeredgecolor='b',
             markerfacecolor='None',
             label="Frequency vs Temp"
            )

    plt.xlabel("Temperature [K]",fontsize=15)
    plt.ylabel("Freq [kHz]",fontsize=15)
    plt.title("$BalrO_{3}$ ba916 5/15/18",fontsize=20)
    plt.grid(True)

    plt.show()
    
def main():
    # Point_Click_Graph: 
    #    * parameters:
    #        1. all the files to be parsed
    #        2. signal data indices in the files (x,y)
    #        3. peak   data indices in the files (x,y)
    #        4. convert function to be applied to the data
    #    * automatically:
    #        * reads in the data from the files,
    #        * parses the data using the convert function
    pcg = Point_Click_Graph(get_files(),[2,3],[0,1],convert)
    
    #      --- Set Plot Parameters ---
    signal_kwargs = { 
                    "linewidth":1, 
                    "linestyle":"-",
                    "color":"green",
                    "label":"Magnitude vs. Frequency"
                    }
    peak_kwargs =   {}
    mpl.rcParams['figure.figsize'] = (11,7) # Set Default Plot Size
    
    # make_plots():
    #    * Generates all of plots, with the peaks that can be clicked
    #    * RETURNS: [dictionary] mapping file_names to a [list] of [tuples],
    #      describing the location of the important peaks [(x,y),(x,y) ... ]
    dict_imp_peaks = pcg.make_plots(signal_kwargs,peak_kwargs) 
    
    print("make plot ...")
    #important_peak_plot(dict_imp_peaks)
    
    # main plot
    Freq = []
    Temp  = []
    for file_name in dict_imp_peaks:
        for peak in dict_imp_peaks[file_name]:
            Freq.append(peak[0])
            Temp.append(float(file_name.split('_')[4][:-1]))
    
    #print("Frequency:\n",Freq)
    #print("Temperature:\n",Temp)
    
    fig = plt.figure()
        
    plt.plot(Temp,Freq,"o", 
             markeredgewidth=2,markeredgecolor='b',
             markerfacecolor='None',
             label="Frequency vs Temp"
            )
    
    plt.xlabel("Temperature [K]",fontsize=15)
    plt.ylabel("Freq [kHz]",fontsize=15)
    plt.title("$BalrO_{3}$ ba916 5/15/18",fontsize=20)
    plt.grid(True)
    
    plt.show()

    x = np.arange(2,100)
    y = x**2
    plt.plot(x,y)
    plt.show()
    
    print("Done")


if __name__ == "__main__":
    main()
