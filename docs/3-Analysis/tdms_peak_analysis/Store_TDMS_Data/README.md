

## Directories ##

1. **Matlab_readTDMS_package**: This directory contains third party functions
                          that are used to read the data in from tdms files,
                          into structs.
2. **LabVIEW interface with Matlab:** I believe this directory just contains 
                                  files, that are used for example calls to the
                                  files in the Matlab_readTDMS_package 
                                  directory.

## Files ##
1. **RUSload.m:** This file contains a function that reads in the data from a tdms
              file into a struct in a desirable format.
2. **Store_TDMS_Data.m:** This file contains a function that **is meant to 
                    be called.** The function in this file:
    * Calls the `RUSload` function 
    * Adds synthesized fields to the struct that is returned from `RUSload` 
    * Reorders the fields in the returned struct.

