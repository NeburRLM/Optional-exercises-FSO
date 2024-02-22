#!/bin/bash

#Obtenir un llistat del directori actual, mostrant només la informació del propietari, el grup, la mida i el nom de cada fitxer;

echo "Propietari Grup Tamany   Nom"
ls -l | awk '{print $3,"\t",$4,"\t",$5,"\t",$10}'	#del ls -l, només mostrem les columnes 3(propietari), 4(grup), 5(tamany) i 10(nom del fitxer/directori)
