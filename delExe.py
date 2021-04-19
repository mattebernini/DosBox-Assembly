import os
import subprocess
import sys

os.chdir(sys.argv[1])

file_exe = []
comando = "rm "

for cartella, sottocartelle, files in os.walk(os.getcwd()):
    for file in files:
        if file.endswith(".exe") | file.endswith(".EXE"):
            file_exe.append(file)

for e in file_exe:
    comando += e + ""

os.system("cd '" + sys.argv[1] + "'")
os.system(comando)