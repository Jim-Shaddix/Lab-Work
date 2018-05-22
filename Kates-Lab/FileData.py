import pandas as pd
import numpy as np
import subprocess

# My Modules
from ClickPlot import click_plot 

class File_Data(object):
    """
    Stores all of the data associated with a single .csv or .xlsx file, 
    in Dr. Ross's experiment
    """
    def __init__(self, file_name, convert, signal_indices=[2,3], 
                 peak_indices=[0,1]):
        '''
        Store Parameters and Synthesized Data 
        '''
        
        # Storing Parameters
        self.file_name      = file_name
        self.signal_indices = signal_indices
        self.peak_indices   = peak_indices
        self.convert        = convert
        
        # Synthesized Data 
        # - This Data Is Instantiated, When store_file_data is Called
        self.signal_headers = None
        self.peak_headers   = None

        self.x_signal       = None
        self.y_signal       = None

        self.x_peak         = None
        self.y_peak         = None

        self.temp           = None

        # Synthesized Data 
        # - this data is instantiated when click_store_sig_peaks is called
        self.sig_peaks      = None
    
    @staticmethod
    def get_files(directory='.'):
        '''
        RETURNS: 
            * list of csv files from a given directory
        PARAMETERS:
            * Directory: specifies the directory with the files you would like 
                         to analyze.
                * By Defualt: this method will use the current directory.
        '''
        
        # use shell command to get file list
        try:
            str_files  = subprocess.check_output(["ls "+directory+" | grep '\.csv$'"],shell=True).decode("utf-8")
        except:
            print("Error in get_files method:\n Did not find any .csv files",
                    "in the directory:",directory)
            exit(0)
        list_files = str_files.split("\n")
        
        # remove empty list elements
        while '' in list_files: list_files.remove('')  
        
        # remove / at end, if it exists
        if directory[-1] =="/":
            directory = directory[:-1]

        # prepend the directory to each file_name
        list_files = [directory+"/"+file_name for file_name in list_files]
            
        return list_files

    def _store_temperature(self):
        '''
        DESCRIPTION:
            * This method returns temperature data by parsing it from the files
              that are used.
            * This method is subject to change, if the file names are changed in the future.
        '''
        no_directory = self.file_name.split('/')[-1]
        self.temp = float(no_directory.split('_')[4][:-1])
                
        return 

    def _store_headers(self):
        '''
        RETURNS: 2-[Lists] of 2-[Strings]
            * The file headers, corresponding to the indices that were passed in.
        '''
        df = pd.read_csv(self.file_name)
        headers = list(df)
        signal_headers = [headers[self.signal_indices[0]]] + \
                         [headers[self.signal_indices[1]]]
        peak_headers   = [headers[self.peak_indices[0]]]  + \
                         [headers[self.peak_indices[1]]]
               
        return signal_headers, peak_headers

    def click_store_sig_peaks(self,fig,ax,signal_kwargs):
        '''
        DESCRIPTION:
        * Uses the click plot function in order to store the significant peaks
        '''
        self.sig_peaks = click_plot(
                                    fig, ax, 
                                    self.x_signal, self.y_signal, 
                                    self.x_peak,   self.y_peak,
                                    signal_kwargs
                                   )
        return

    def store_file_data(self):
        '''
        DESCRIPTION:
            1. reads in all of the data, from all of the files
            2. splits the data into signal, and peak dataframes 
            3. parses all of the data
            4. stores headers, and all of the data associated with 
               a file in instance variables.
        '''
        
        # Read Data
        df = pd.read_csv(self.file_name)
        
        # Store Headers
        self.signal_headers, self.peak_headers = self._store_headers()
        self._store_temperature()
        self.get_files

        # Sepperate DataFrames
        df_signal  = df[self.signal_headers]
        df_peak    = df[self.peak_headers]

        # Drop Empty Rows
        df_signal = df_signal.dropna(axis=0) 
        df_peak   = df_peak.dropna(axis=0) 

        # Convert Data to Floats
        if self.convert is not None:
            df_signal = df_signal.applymap(self.convert)
            df_peak   = df_peak.applymap(self.convert)

        # Signal/Peaks to Plot
        self.x_signal = df_signal[self.signal_headers[0]]
        self.y_signal = df_signal[self.signal_headers[1]]
        self.x_peak  = df_peak[self.peak_headers[0]]
        self.y_peak  = df_peak[self.peak_headers[1]] 
        
        return 

