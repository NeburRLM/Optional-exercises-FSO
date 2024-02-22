#!/bin/bash

#Exercici 3. Feu un script anomenat “exer3” que, donada una llista de números introduïda com argument, retorni els valors mínim, mig i màxim de tots aquests números. Si no s’introdueixen almenys dos números, cal mostrar un missatge d’error.


#Comprobem si s'han introduït al menys 2 numeros
if [ $# -lt 2 ]
then
  echo "Error ./exer3: cal adjuntar al menys 2 numeros"
  exit 1
fi

#Ordenem els numeros introduïts de menor a major
params=($(echo "$@"))	# guardem els paràmetres en una llista
#echo "${params[@]}"
sorted=($(printf '%s\n' "${params[@]}" | sort -n ))	#ara ordenem els paràmetres agafats de la llista
#echo "${sorted[@]}"



#Assignem el valor mínim y màxim dels numeros ja ordenats
min=${sorted[0]} #mínim
max=${sorted[$(( $# - 1 ))]}	#màxim

#Calculem i assignem el valor mig
suma=0
if [ $# -eq 2 ]		# si el número de paràmetres és igual a 2, calcula el mig a partir del valor mínim i màxim
then
	mig=$(( ( $min + $max ) / 2 ))
else			# si el número de paràmetres és diferent de 2 (hi haurà més de dos paràmetres)
	for val in $*	# per cada valor dels paràmetres que ha introduït l'usuari
	do
		let suma=val+suma	# anem sumant el contingut de cadascun	
	done
		mig=$((suma/$#))	# una vegada acabat el bucle del sumatori, dividem aquest resultat per el número de paràmetres i així calculem el valor mig	  	    
fi


#Mostrem els resultats
echo "min = $min"
echo "mig = $mig"
echo "max = $max"

