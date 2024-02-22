#!/bin/bash

#Exercici 2. Feu un script anomenat “exer2” que, a partir de dos números d’entrada, mostri per pantalla el quocient de la seva divisió (primer argument / segon argument) i que el codi de retorn sigui la resta de la divisió.

#Guardem els dos números que introdueix l'usuari en dos variables diferents
num1=$1	
num2=$2

resultat=$(($num1/$num2))	#Calculem la divisió i guardem el valor resultant
residu=$(($num1%$num2))		#Calculem el mòdul i guarden el valor reultant

echo "$num1 / $num2 = $resultat"	#Imprimim el valor resultant de la divisió

exit $residu				#Retornem el valor del residu
