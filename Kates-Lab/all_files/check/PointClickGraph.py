import matplotlib as mpl
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

class Point_Click_Graph():
    """
    * Builds graphs with clickable points from given files, 
      and records the points that are clicked.
    
    * Only Applicable For:
            - Files that all have their data in the same column indices
            - All the columns in the file need to have their data convereted,
              using the same convert function
              
    * Make More Applicable:
            - This class can be made to be applicable for more general forms of data, 
              if some prepocessing is done on the files. In such a case, 
                  - The convert function may not need to do anything,
                  - And all of the columns in the file can be made to represent the appropriate data,
                    which would make this class appriopriate to use.
    """

    def __init__(self, file_names, signal_indices, point_indices, convert = None):
        """
        PARAMETERS:
            * :file_names: [Iterable] of   [Strings] All the files that will be analyzed
            * :signal/point indices: [Iterable] of 2 [Integers]:
                - [x_indice, y_indice]
                - each integer represents the indice in the csv file that corresponds
                  to x/y signal/point data.
            * convert: [function] The function that will be used to convert the values 
                                      in the files to integers
        """
        # provided data
        self.file_names     = file_names
        self.signal_indices = signal_indices
        self.point_indices  = point_indices
        self.convert = convert
        
        # synthesized data
        self.signal_headers, self.point_headers = self._get_headers()
        self.dict_data = self._store_file_data()
        
    def _get_headers(self):
        '''
        RETURNS: 2-[Lists] of [Strings]
            * The headers, corresponding to the indices that were passed in.
        '''
        df = pd.read_csv(self.file_names[0])
        headers = list(df)
        signal_headers = [headers[self.signal_indices[0]]] + \
                         [headers[self.signal_indices[1]]]
        point_headers  = [headers[self.point_indices[0]]]  + \
                         [headers[self.point_indices[1]]]
            
        return signal_headers, point_headers
        
    def _store_file_data(self):
        '''
        DESCRIPTION:
            1. reads in all of the data, from all of the files
            2. parses all of the data
            3. splits the data into signal, and peak dataframes 
        RETURNS: [Dictionary]:
            - KEY:   [String] file_name
            - VALUE: [Tuple] of [dataframes] -> (signal-DataFrame, point-DataFrame)
        '''

        file_to_data = {}

        for read_file in self.file_names:

            # Read Data
            df = pd.read_csv(read_file)

            # Sepperate DataFrames
            df_signal  = df[self.signal_headers]
            df_peak    = df[self.point_headers]

            # Drop Empty Rows
            df_signal = df_signal.dropna(axis=0) 
            df_peak   = df_peak.dropna(axis=0) 

            # Convert Data to Floats
            if self.convert is not None:
                df_signal = df_signal.applymap(self.convert)
                df_peak   = df_peak.applymap(self.convert)

            # Store data in dictionary, with file key
            file_to_data[read_file] = (df_signal,df_peak)

        return file_to_data

    def _get_plot_data(self, file_name):
        '''
        RETURNS: [tuple] of [arrays]:
            - the data from a single file that can than be plotted.
        '''

        # Signal to Plot
        df_signal = self.dict_data[file_name][0]  
        x = df_signal[self.signal_headers[0]]
        y = df_signal[self.signal_headers[1]]

        # Points To Plot
        df_point = self.dict_data[file_name][1]
        x_point  = df_point[self.point_headers[0]]
        y_point  = df_point[self.point_headers[1]]

        return x,y,x_point,y_point

    def make_plots(self, signal_kwargs={}, point_kwargs={}):
        '''
        DESCRIPTION:
            - Plots the data from all of the files one at a time.
            - These plots have clickable peaks. Everytime, a click is made on 
              a peak, the position of the peak is recorded. If the peak is 
              clicked on again, it will remove the record of that peak.
        RETURN:
            - returns a dictionary:
                - KEY: name of the file
                - VALUES: [List] of [Tuples] (x-coordinate, y-coordinate)
                          that describes the peaks that were clicked on. 
                          (if a peak is clicked again, it will be removed from 
                          this list.)
        '''

        # Dictionary that is returned
        important_points = {} 

        for file_name in self.dict_data:

            important_points[file_name] = []
 
            #      --- Basic Plot Info ---
            fig, ax = plt.subplots()                # Create Plot
            plt.ion()                               # Interactive mode on
    
            #      --- Get Signal and Peak Data ---
            x, y, x_points, y_points = self._get_plot_data(file_name)
  

            #      --- Make Plots --- 
            # Signal Plot
            ax.plot(x, y, **signal_kwargs)
            
            # Point Plot
            coll = ax.scatter(x_points, y_points, color=["blue"]*len(x_points),
                              picker=5,label="Point Data",**point_kwargs)
            
            # Set Axes Info 
            ax.set_xlim(0,np.max(x_points)+0.2*np.max(x_points))
            ax.set_ylim(0,np.max(y_points)+0.2*np.max(y_points))
            ax.set_xlabel("Frequency")
            ax.set_ylabel("Magnitude")
            ax.set_title(file_name)
            ax.legend(loc="upper right")

            print("File:",file_name)
            
            
            #      --- Clickable Event ---
            def on_pick(event):

                # index of the array, were the event occurred
                ind = event.ind[0]

                # where the event ocurred
                x_val, y_val = x_points[ind], y_points[ind]

                # add point
                if [x_val,y_val] not in important_points[file_name]:

                    # color is speciified by: RGBA tuple
                    # https://www.cgl.ucsf.edu/chimera/docs/ProgrammersGuide/Examples/footnotes/rgba.html
                    important_points[file_name].append([x_val,y_val])
                    coll._facecolors[ind,:] = (1, 0, 0, 1)
                    coll._edgecolors[ind,:] = (1, 0, 0, 1)
                    print("\t  Picked  Point [ {:>3} ] at: [ {:06.2f}, {:06.5f} ]".format(ind,x_val,y_val))

                # remove point
                else:

                    important_points[file_name].remove([x_val,y_val])
                    coll._facecolors[ind,:] = (0, 0, 1, 1)
                    coll._edgecolors[ind,:] = (0, 0, 1, 1)
                    print("\t  Removed Point [ {:>3} ] at: [ {:06.2f}, {:06.5f} ]".format(ind,x_val,y_val))

                fig.canvas.draw()

            fig.canvas.mpl_connect('pick_event', on_pick)

            # Add blocking to stop the program until graphs are built
            plt.show(block=True)

        return important_points

        
