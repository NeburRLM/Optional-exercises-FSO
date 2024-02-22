#!/bin/bash

#Dins el directori “Dt” (DadesTemperatura), ajuntar tots els fitxers d’una població determinada en un sol fitxer; 



# Directori a recorrer (actual)
directori="."

# Obtenim la població específica
echo "Introdueix la població: "
read poblacio
poblacio="${poblacio}.tem"	#concatenem amb .tem per a buscar la població introduïda per l'usuari

# Creem un arxiu buit per guardar la informació amb el nom de la poblacio.tem
touch "poblacio_$poblacio.txt"

# Recorregut de tots els subdirectoris del directori
for subdirectori in $directori/Dt/DadesTemperatura/*; do
  # Verifica si el subdirectori es un directori
  if [ -d "$subdirectori" ]; then
    # Recorregut de tots els arxius en el subdirectori (directori any)
    for arxiu in $subdirectori/*; do	#dins de cada any, mira si el fitxer de la població correspon amb algun fitxer del directori any
      #echo $arxiu
	if [ "$(basename "$arxiu")" = "${poblacio}" ]; then   #sense tenir en compte el path, només el nom de l'arxiu (basename)
  		#echo "$arxiu"
  		cat "$arxiu" >> "poblacio_$poblacio.txt"	#concatenem la informació a cada bucle d'escriptura, sense eliminar el que hi havia abans (>>)
	fi
    done
  fi
done

echo "Arxiu de la població $poblacio creat amb èxit."

