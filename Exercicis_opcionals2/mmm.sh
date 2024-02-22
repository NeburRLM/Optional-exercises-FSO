#!/bin/bash

#Feu un script que donat un fitxer de temperatures ‘.tem’, calculi la temperatura mínima, mitja i màxima de tot l’any (./mmm poblacio.tem); 

echo "Introdueix l'any que vols analitzar: "
read any	# obtenim l'any del fitxer .tem

echo "Introdueix el nom específic de la població que vols analitzar: "
read poblacio	#obtenim la població
poblacio="${poblacio}.tem"	#concatenem el nom de la població amb la terminació .tem per treballar correctament amb ell

arxiu=./Dt/DadesTemperatura/$any/$poblacio	#obtenim el path del fitxer .tem a analitzar

temperatures_min=$(cat "$arxiu" | awk '{print $2}')	#obtenim els valors de la columna de temperatures mínimes
#echo "${temperatures_min[@]}"
temperatures_min_sorted=$(echo "$temperatures_min" | sort -n)	#ordenem aquestes temperatures mínimes de menor a major
min_temperatura=$(echo "$temperatures_min_sorted" | tail -n +2 | head -1) #guarda la temperatura mínima, fen un echo per mostrar totes les temperatures mínimes, després d'això es salta la primera línea i per últim de la llista resultant, es guarda el primer valor que serà el mínim (ja que la llista està ordenada de menor a major)

temperatures_max=$(cat "$arxiu" | awk '{print $4}')	#obtenim els valors de la columna de temperatures màximes
#echo "${temperatures_max[@]}"
max_temperatura=$(echo "$temperatures_max" | sort -n | tail -1)	#de la llista de temperatures màximes, ens quedem amb l'últim valor de la llista (ja que els valors estan ordenats de menor a major)

temperatures_mig=$(cat "$arxiu" | awk '{print $3}' | tail -n +2) #creem laa llista de temperatures mitjanes i ens quedem amb els valors corresponents (saltant-nos el primer valor qiue es el string de la columna)
echo ${temperatures_mig[@]}	
suma=0
for val in $temperatures_mig	#per cada valor de la llista de temperatures mitjanes
do
    suma=$(awk -v suma="$suma" -v val="$val" 'BEGIN { printf "%.2f", suma + val }') #definim dos variables per realitzar les sumes corresponents en format de 2 decimals i el resultat ho guardem en suma
done
num_elementos=$(echo ${temperatures_mig[@]} | wc -w)  # num d'elements de la llista
mig_temperatura=$(awk -v suma="$suma" -v num_elementos="$num_elementos" 'BEGIN { printf "%.2f", suma / num_elementos }') #divisió per calcular la temperatura mitjana a partir del mateix format de càlcul anterior de decimals

#mostrem resultats
echo "La temperatura mínima es $min_temperatura"
echo "La temperatura màxima es $max_temperatura"
echo "La temperatura mitjana es $mig_temperatura"

