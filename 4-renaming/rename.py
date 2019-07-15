import os
from pathlib import Path
"""
   1. "spxxx_SampleName_xxxK_xxOe_xxxx-xxxxKHz.tdms" 
   2. "spxxx_SampleName_xxxK_xxxx-xxxxKHz.tdms"
"""
old_names = "old_names.txt"

def generate_example_files(path_temp = None, path_field = None, path_old = None):
    """
        generates example file names in the directories specified by:
            - path_temp
            - path_field
    """

    sample_name = "TaV2"
    min_freq  = 100
    max_freq  = 1000
    init_temp = 300
    init_field = 20

    if path_temp != None:

        for i in range(0,12):
            temp_file_name = "sp" + "{:0>3}".format(i)           + "_" + \
                             sample_name                         + "_" + \
                             "{:0>3}".format(init_temp - i*5)    + "_" + \
                             str(min_freq) + "-" + str(max_freq) + "KHz.tdms"
            with open(path_temp / temp_file_name, 'a'): pass

    if path_field != None:
        for i in range(0,12):
            temp_file_name = "sp" + "{:0>3}".format(i)                + "_" + \
                             sample_name                              + "_" + \
                             "{:0>3}".format(init_temp)               + "_" + \
                             "{:0>2}".format(init_field + 5*i) + "Oe" + "_" + \
                             str(min_freq) + "-" + str(max_freq) + "KHz.tdms"
            with open(path_field / temp_file_name, 'a'): pass

    if path_old != None:
        with open(old_names) as fd:
            file_names = fd.readlines()

        for fname in file_names:
            with open(path_old / fname, 'a'): pass

def remove_files(path_temp = None, path_field = None, path_old = None):

    def rm_files(folder):
        for the_file in os.listdir(folder):
            file_path = os.path.join(folder, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
            except Exception as e:
                print(e)

    if path_temp != None:  rm_files(path_temp)
    if path_field != None: rm_files(path_field)
    if path_old != None:   rm_files(path_old)

def detect_file_name_type(fname):

    # old filetype test
    try:
        int(fname.split("_")[1])
    except:
        return "old"

    # magnetic field file_type test
    try:
        if "Oe" == fname.split("_")[3][-2:]: return "field"
    except Exception as e:
        print("Error checking if file is magnetic field type: ",fname)
        print(e)

    # temperature file_type is the only one left
    return "temp"

def parse_file_name(fname):
    pass

def create_index():
    pass

def main():
    # path to files to rename
    path_temp  = Path("Ex_Temp")
    path_field = Path("Ex_Field")
    path_old   = Path("Ex_Old")
    paths = (path_temp, path_field, path_old)

    # remove files in example directories
    remove_files(*paths)

    # generates some example files.
    generate_example_files(*paths)

if __name__ == "__main__":
    main()
    print("FINISHED")