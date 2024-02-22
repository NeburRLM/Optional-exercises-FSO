#!/bin/bash


#Trobar la temperatura màxima d’un fitxer “.tem” qualsevol, utilitzant “sort -n”; 


echo "Introdueix l'any que vols analitzar: "
read any

echo "Introdueix el nom específic de la població que vols analitzar: "
read poblacio
poblacio="${poblacio}.tem"	#concatenem el nom de la població que ens ha indicat l'usuari amb .tem

arxiu=./Dt/DadesTemperatura/$any/$poblacio	#obtenim el path que ens ha indicat l'usuari

# Processem les dades y obtenim la temperatura màxima
temperatures=$(cat "$arxiu" | awk '{print $4}')
echo $temperatures	#obtenim les temperatures de la columna de temperatures màxima del fitxer de la població indicada
max_temperatura=$(echo "$temperatures" | sort -n | tail -1)	#de les temperatures obtingudes anteriorment, les ordenem de menys a més i obtenim l'últim valor (tail -1) de la llista ordenada que serà el més gran

echo "La temperatura màxima es $max_temperatura"



