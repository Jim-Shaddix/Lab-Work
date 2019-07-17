
import os

files = os.listdir()
for f in files:
    if f.endswith(".tdms"):
        temp = f.split("_")[3][:-1]
        dir = "CoNb206-" + temp + "K"
        os.rename(f,os.path.join(dir,f))

print("[Finished]")
