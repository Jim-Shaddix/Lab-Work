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

import matplotlib as mpl
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import subprocess

# My Module
from PointClickGraph import Point_Click_Graph


def get_files(directory='.'):
    '''
    Returns: 
        - list of csv files from a given directory
    Parameters:
        - Directory: specifies the directory with the files you would like to analyze.
            - By Defualt: this method will use the current directory.
    '''
    
    # use shell command to get a string representation of all the csv files
    str_files  = subprocess.check_output(["ls "+directory+" | grep '\.csv$'"],shell=True).decode("utf-8")
    list_files = str_files.split("\n")
    
    # remove empty list elements
    while '' in list_files: list_files.remove('')  
        
    return list_files

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



def main():
    print("           START OUTPUT\n")
    
    print("\n           END OUTPUT")


if __name__ == "__main__":
    main()





