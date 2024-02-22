#!/bin/bash

#Obtenir un fitxer amb els noms dels usuaris


echo "Els usuaris connectats actualment son: "
who | awk '{print $1}' > usuaris_connectats.txt
#who-> mostra tota la informació sobre els usuaris connectats actualment
#awk-> extrau només el nom de l'usuari de cada linea de sortida del who (primera columna de la linea)
cat usuaris_connectats.txt	#mostrem el contingut sencer del fitxer creat

