
# Problem Statement: #
In this lab, we are trying to find all of the peaks, in some signal data.
This problem is made more difficult by the fact that the data is very noisy.
We want to find the peaks in the dataset, that are representitive of the 
signal, but not that of the noise. 

# What I Was Given: #
* [.xlsx .csv] files: that contain all of the signal data, and some first 
  guesses as to what the more significant peaks are. 

# Current Solution: #
* I have written some python code that will incrementally display the data
  contained in each file, in an interactive graph.
    - The graphs have a built in click feature, that will allow you to click 
      on all of the plotted peaks. When a peak is clicked on, this indicates
      to the program that this peak is coming from the signal data, and not
      from the noise, and this point will be tracked by the program. 
      Points that are being tracked may also be clicked on again in order to
      indicate to the program that a particular point should no longer be 
      tracked.
    - This effectively delegates the labor of choosing the significant peaks
      to the user of the program.

# Goals: #
* It would be better if I developed a program that could find the most 
  significant peaks on its own.
    - I will try out a few different peak finding algorithems, until I can 
      find one that works appropriately.
