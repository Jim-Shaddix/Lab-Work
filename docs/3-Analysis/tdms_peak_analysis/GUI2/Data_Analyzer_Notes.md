
# Functions #
* `Update_Plot_Info`
    - copies `plot_info` from the current tdms struct.
    - sets all the fields from the GUI.
    - copies the current `plot_info` object to all of the other structs.

* `Set_Recalc_All`
    - sets `recalculate` to true in the `plot_info` object for all of 
           the structs.
    ---- clears all of the peaks across all the tdms structs prviously.

* `Reprocess`
    - calls `Update_Plot_Info`
    - checks if the `reprocess` field is true.
        - reprocess = True: calls `Process_Data`
        - reprocess = False: nothing
    - plots the file

