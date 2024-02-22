#!/bin/bash

#Trobar la temperatura màxima de tots els fitxer “.tem” que hi hagin dins l’arbre de subdirectoris del directori actual de treball;


max_temp=-1000.0  # Inicialitzem una temperatura molt baixa com a valor màxim
max_temps=()  # Inicialitzem un array buit per guardar les temperatures màximes

# Busquem tots els fitxers .tem a l'arbre de subdirectoris del directori actual de treball i els emmagatzemem en una variable.
tem_files=$(find . -name "*.tem")

# Iterem sobre cada fitxer trobat i busquem la temperatura màxima.
while IFS= read -r filename; do


  # Llegim la temperatura de la darrera columna del fitxer i la comparem amb la temperatura màxima actual
  temperatures=$(awk '{print $4}' "$filename")
  aux=$(echo "$temperatures" | sort -n | tail -1) # de les temperatures obtingudes anteriorment, les ordenem de menor a major i obtenim l'últim valor (tail -1) de la llista ordenada que serà el més gran


  if awk -v aux="$aux" -v max_temp="$max_temp" 'BEGIN {exit !(aux > max_temp)}'; then    
    max_temp=$aux
    max_temps+=("$max_temp")   # Afegim la temperatura màxima actual a l'array
  fi
done <<< "$tem_files"


max_temp=${max_temps[0]}
for temp in "${max_temps[@]}"; do
  # Si temp és més gran que max_temp, s'actualitza el valor de max_temp amb el valor de temp.
  if awk -v temp="$temp" -v max_temp="$max_temp" 'BEGIN {exit !(temp > max_temp)}'; then #-v per a la comparació mitjançant awk

#Si la comparació és certa, se surt de l'script Awk (utilitzant l'instrucció èxit) amb un valor d'èxit (èxit 0), la qual cosa significa que el valor de temp és més gran que max_temp. En cas contrari, se surt de l'script Awk amb un valor de fals (èxit 1), cosa que significa que el valor de temp no és més gran que max_temp.

    max_temp=$temp
  fi
done

echo "La temperatura màxima es: $max_temp"






