import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from argparse import ArgumentParser

# my modules
from FileData import File_Data
from ClickPlot import click_plot

def convert(val):
    '''
    DESCRIPTION:
        - converts a string into a float.
        - this function is passed into the File_Data constructor
        - this function will be called on every data point in the data
          that is being analyzed by File_Data
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

def important_peak_plot(freq,temp):
    '''
    DESCRIPTION:
        * Generates a composite plot, from all of the peaks that were clicked
        * Frequency vs. Temperature
    '''

    # create plot
    fig = plt.figure()

    # plot info
    plt.plot(temp,freq,"o",
             markeredgewidth=2,markeredgecolor='b',
             markerfacecolor='None',
             label="Frequency vs Temperature"
            )

    # set info
    plt.xlabel("Temperature [K]",fontsize=15)
    plt.ylabel("Freq [kHz]",fontsize=15)
    plt.title("$BalrO_{3}$ ba916 5/15/18",fontsize=20)
    plt.grid(True)

    plt.show()

def main():

    # Get Arguments
    parser = ArgumentParser()
    parser.add_argument(
        '--data_dir',
        type=str,
        default='.',
        help="""\
        Location of the data files that will be analyzed. Defaults to the\
        current directory.
        """)
    paramDict = parser.parse_args()
    directory = paramDict.data_dir

    # get files
    data_files = File_Data.get_files(directory)

    # Set Default Plot Size
    mpl.rcParams['figure.figsize'] = (11,7)


    #      --- Store The File Data and Plot ---

    # signal key-word-arguments for the plot
    signal_kwargs = {
                    "linewidth":1,
                    "linestyle":"-",
                    "color":"green",
                    "label":"Magnitude vs. Frequency"
                    }

    # data, associated with the important peaks
    frequencies  = []
    temperatures = []

    # store file data, and important peak information
    for file_name in data_files:

        # store file data
        fd = File_Data(file_name,convert)
        fd.store_file_data()

        print("\nFile: ",fd.file_name)

        # set plot parameters
        fig, ax = plt.subplots()
        ax.set_xlabel("Frequency")
        ax.set_ylabel("Voltage Magnitude")
        ax.set_title(fd.file_name)
        ax.set_xlim(0,np.max(fd.x_signal)+0.2*np.max(fd.x_signal))
        ax.set_ylim(0,np.max(fd.y_signal)+0.2*np.max(fd.y_signal))

        # Make Interactive Plot
        # And Store The Significant Peaks
        fd.click_store_sig_peaks(fig,ax,signal_kwargs)

        for peak in fd.sig_peaks:
            frequencies.append(peak[0])
            temperatures.append(fd.temp)

    important_peak_plot(frequencies,temperatures)

if __name__ == "__main__":
    main()


