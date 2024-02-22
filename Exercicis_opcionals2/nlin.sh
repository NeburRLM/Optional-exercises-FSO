#!/bin/bash

#Feu un script que escrigui la línia x d’un fitxer de text (./nlin x fitxer); 

# Verifiquem que s'hagi introduït el número de linia i el nom de l'arxiu
if [ $# -ne 2 ]
then
  echo "Error: s'han de introduïr dos arguments (número de linia i nom de l'arxiu)"
  exit 1
fi

# Verifiquem que el fitxer existeixi
if [ ! -f $2 ]
then
  echo "Error: el arxiu $2 no existeix"
  exit 1
fi

# Mostrem la linia x del fitxer especificat per paràmetre
linia=$(sed -n "$1p" $2) #Guardem la linea especificada en el primer argument a partir de la impressió d'aquesta mitjançant l'expressió p
echo $linia	#mostrem el resultat


