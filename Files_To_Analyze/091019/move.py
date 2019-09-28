import subprocess as sub

with open("files_to_move.txt") as fd:
    for file in fd:
        sub.call(f"cp {file.strip()} test/", shell=True)
