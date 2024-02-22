#!/bin/bash

#Feu un script que substitueixi els espais en blanc per un ‘_’ en els noms dels fitxers continguts dins d’un directori (./sblanc dir);

# Verifiquem que s'hagi proporcionat un directori
if [ $# -ne 1 ]; then
  echo "Error: has de proporcionar un directori"
  exit 1
fi

# Obtenim els noms dels arxius dins del directori i els anem separant amb una coma
dir=$1
files=$(ls $dir | tr '\n' ',')
#echo "$files"

# Fem un recorregut dels noms dels arxius (que es troben separats per una , en la variable files) i els reemplacem
IFS=','
for file in $files; do
	newfile=$(echo $file | tr ' ' '_')
	mv "$dir/$file" "$dir/$newfile"	#modifiquem nom
done


