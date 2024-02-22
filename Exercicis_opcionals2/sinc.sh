#!/bin/bash

#Feu un script que compari els arxius continguts en dos directoris i, quan detecti el mateix nom d’arxiu als dos directoris, copiï la versió més nova (data d’actualització més recent) sobre la versió antiga (./sinc dir1 dir2); 

#Guardem els paràmetres introduïts per l'usuari
dir1=$1
dir2=$2

for file in "$dir1"/*; do	#inicialitza un recorregut pel directori mirant cada fitxer existent
  filename=$(basename "$file")	#per quedarnos només amb el nom del fitxer sense tenir en compte el path sencer
  file2="$dir2/$filename"	#concatenem dir2 amb el fitxer amb una barra per formar el path complet del fitxer de destí
  if [ -f "$file2" ]; then	#mirem si el segon fitxer existeix
    if [ "$file" -nt "$file2" ]; then	#amb la comanda -nt, mirem quina versió es més recent
      cp -f "$file" "$file2"	#si el fitxer1 es mes nou que el fitxer2, es copia el contingut del primer al segon fitxer
    fi
  fi
done


