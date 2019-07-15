import pandas as pd
import os

sample_name = input("Sample Name: ")

starting_freq = input("Starting Frequency (kHz): ")
ending_freq = input("Ending Frequency (kHz): ")
freq_range = starting_freq + "-" + ending_freq + "kHz"

output = sample_name + "_" + freq_range + "_"

path1 = 'C:\\Data\\'
path2 = input("Input Subfolders (ex. May_2018\052318): ")
path = path1+path2

csv_path1 = input("CSV File Name: ")
csv_path = path + csv_path1

# csv_path = 'run1 short.csv'
# sample_name = 'Barryum_916'
# freq_range = '100-1000'
# path = '/home/cepheid/Documents/Atom Workspace/RUS data/'

df = pd.read_csv(csv_path, index_col=False, header=None)

for filename in os.listdir(path):

    if filename[:2] != 'sp': continue
    file_header = filename[:5]
    row_header = df.loc[df[0] == file_header, 0].to_string(index=False)
    row_temp = df.loc[df[0] == file_header, 1].to_string(index=False)
    row_mag = df.loc[df[0] == file_header, 2].to_string(index=False)

    new_name = filename[:12] + '_' + sample_name + '_' + row_temp + 'K_' + row_mag + 'oe_'+ freq_range + 'kHz'
    os.replace(os.path.join(path, filename), os.path.join(path, new_name + '.tdms'))
    # old_name = filename[:12]
    # os.replace(os.path.join(path, filename), os.path.join(path, old_name + '.csv'))
