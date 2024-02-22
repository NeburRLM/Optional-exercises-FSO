#!/usr/bin/env python

#!/usr/bin/env python3
import os
import sys
import compdir

# Comprovem que s'hagin passat dos arguments per paràmetre
if len(sys.argv) < 3:
    print("Usage: comptot.py dir1 dir2")
    sys.exit(1)

dir1 = sys.argv[1]
dir2 = sys.argv[2]

# Comprovem que els dos arguments són directoris existents
if not os.path.isdir(dir1):
    print(f"{dir1} is not a directory")
    sys.exit(1)
if not os.path.isdir(dir2):
    print(f"{dir2} is not a directory")
    sys.exit(1)

# Cridem la funció compdir per comparar els dos directoris i obtenir el path de l'arxiu més recent
arxiu_recent = compdir.compdir(dir1, dir2)

# Guardem el path de l'arxiu més recent en el fitxer recents.log
with open("recents.log", "w") as f:
    f.write(arxiu_recent + "\n")

# Calculem el percentatge de similitud entre els dos directoris
total_files1 = len([f for f in os.listdir(dir1) if os.path.isfile(os.path.join(dir1, f))])
total_files2 = len([f for f in os.listdir(dir2) if os.path.isfile(os.path.join(dir2, f))])
total_files = total_files1 + total_files2
similitud = (total_files - compdir.dif_files) / total_files * 100

# Mostrem el percentatge de similitud per la sortida estàndard
print(f"Percentatge de similitud: {similitud:.2f}%")

