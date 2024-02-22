#!/bin/bash

# 5.- Crearem un script bash comptot.sh i un script python comptot.py que
# usant la funció compdir.sh compari les dues rutes que rebrà per paràmetre de
# manera recursiva. També volem que indiqui per la sortida estàndard el
# percentatge total de similitud de les dues rutes rebudes per paràmetre. I que
# en l'arxiu recents.log i hi hagi la informació de totes les rutes absolutes més
# noves.


function tipus() {				#declaració de la funció tipus
	local val=0  				#variable val con valor por defecto de 0
    	if [ -f "$1" ]; then			#mira si el paràmetre que li passem és un fitxer
        	val=1  				#actualiza el valor de val a 1 si és un fitxer
    	fi
	if [ -d "$1" ]; then  			#mira si el paràmetre que li passem és un directori
        	val=2				#actualiza el valor de val a 2 si és un directori
    	fi
	if ! [ -f "$1" ] && ! [ -d "$1" ]; then	#mira si el paràmetre que li passem no és ni un fitxer ni un directori
        	val=3				#actualiza el valor de val a 3 si compleix les condicions anteriors
    	fi
    	echo "$val"  				#ens mostrarà el valor retornat segons el cas
}




function compfitxer() {				#declaració de la funció compfitxer
	
	# Obtenir el total de línies en ambdós fitxers (sense comptar línies en blanc)
	#cat "$1" "$2" -> Concatenem el contingut dels dos arxius
	#grep -vc '^$' -> Busca les linies que no esten buides i després fa un count per calcular el total de linies entre els dos fitxers concatenats tenint en compte el pipe anterior	
	total=$(cat "$1" "$2" | grep -vc '^$')
	#s=$(cat "$1" "$2" | grep -v '^$')
	#echo "$total"
	#echo "$s"
	
	#Comprova si els fitxers son buits. Si ho son retornarà un error
	if [ $total -eq 0 ]; then
    		echo "Error: al menys un dels fitxers és buit" >&2
    		exit 1
    	fi

	# Obtenir el nombre de línies diferents usant diff
	#-i -> fa que diff ignori les diferències entre majúscules i minúscules
	#-b -> fa que diff ignori els canvis als espais en blanc
	#-B -> fa que diff ignori les línies buides que només contenen espais en blanc
	#grep "^>" -> només té en compte les linies que treu diff amb > (que indica que es diferent la linea del fitxer2 amb la del fitxer1)
	#wc -l -> conta les linies tenint en compte la sortida del pipe anterior
	liniesDif_primerF=$(diff -i -b -B "$1" "$2" | grep "^>" | wc -l)	
	liniesDif_segonF=$(diff -i -b -B "$1" "$2" | grep "^<" | wc -l)
	linies_dif=$((liniesDif_primerF+liniesDif_segonF))	
	#echo "$linies_dif"

	# Calcula el número de linies iguals sense tenir en compte les files en blanc, calculant la diferència de linies totals entre els dos arxius i les linies diferents a partir de la comanda anterior
	linies_iguals=$((total - linies_dif))

	# Calcula el percentatge de similitud
	simil=$((linies_iguals * 100 / total))

	# Mostrar el percentatge de similitud i les línies diferents
	echo "Percentatge de similitud: $simil%"
	echo "Línies diferents:"
	#Mostra per la sortida d'error només les el contingut de les línies diferents, eliminant totes les línies buides de la sortida de la consulta de cada fitxer.
	#A més, imprimim la sortida de la consulta a partir de la segona línea, saltant-nos la info de les línies diferents de cada fitxer.                                     
	#^ -> indica el començament de la línia
     	#\s -> és un caràcter despai en blanc
	#* -> indica que hi ha zero o més espais en blanc
     	#$ -> indica el final de la línia
     	#/d -> és la comanda set que indica que la línia coincident ha de ser eliminada
	diff -i -b -B <(sed '/^\s*$/d' "$1") <(sed '/^\s*$/d' "$2") | tail -n +2 >&2	
			
}


function compdir() {				#declaració de la funció compdir		
	arxiu_recent=				#variable que guardarà el fitxer més recent en quant a modificacions

	for arxiu1 in $1/*; do			#bucle de recorregut per cada arxiu dins del directori1 especificat
		nom1=$(basename $arxiu1)	#obtenim el nom de l'arxiu en el recorregut del directori1
	  	arxiu2="$2/$nom1"		#concatenem el nom del directrori2 amb el nom de l'arxiu del directori 1
	  	if [ -f $arxiu2 ]; then		#si es path especificat en el directori2, es farà la comparació
			compfitxer $arxiu1 $arxiu2	#crida a la funció compfitxer per comparar els fitxers que tenen el mateix nom y que es troben en els dos directoris diferents passats per paràmetre
	    		if [ "$arxiu1" -nt "$arxiu2" ]; then	#comprova si l'arxiu1 és més nou que l'arxiu2	
				arxiu_recent=$(realpath "$arxiu1")	#si es compleix, l'arxiu més recent serà el del directori1
	    		else
				arxiu_recent=$(realpath "$arxiu2")	#si no es compleix, l'arxiu més recent serà el del directori2	
	    		fi
	  	fi
		
	done

	if [ -z "$arxiu_recent" ]; then		#comprovem si la longitud de la cadena que guarda la variable es 0. Si és 0, llavors significarà que no s'ha trobat cap fitxers amb el mateix nom
  		echo "No s'ha trobat cap arxiu en comú"
	else
  		echo "$arxiu_recent" > recents.log #pel contrari, es guardarà el path de l'arxiu més recent que conté la variable arxiu_recent en un fitxer de text anomenat recents.log
	fi
}


# En aquesta funció volem comprar de manera recursiva les rutes que es pasaran per parametre,
# on mostrarem per sortida estàndar el percentatge de similitud entre aquestes
# També volem que al fitxer recent.log hi hagi la informacio de totes les rutes absolutes més noves.

function comptot() {

	# Bucle para iterar sobre los ficheros y subdirectorios en el directorio
	for ITEM in $1/*; do

	    # Comprueba si el ITEM es un subdirectorio
	    if [ -d "$ITEM" ]; then
		echo "hola"
		echo "$ITEM"
		echo "$ITEM" | sed 's#^/[^/]*/##'

		# COMPARA A NIVELL DE DIRECTORIS
		compdir $ITEM #DIRECTORI_RUTA2

	    # Comprueba si el ITEM es un fichero
	    elif [ -f "$ITEM" ]; then
		echo "$ITEM es un fichero"

		compfitxer $ITEM #$fit2
		
		
	    fi
	done
	#---------------------------------------------------------------------------------
	compara $1 $2
	#---------------------------------------------------------------------------------
	
	info_ruta $1

}

function info_ruta() {

	#-----------------------------------------------------------------------------
	#ara ficarem a el fitxer recents.log la info de les rutes més noves
	# Obtener la lista de rutas absolutas ordenadas por fecha de modificación (la más nueva primero)
	RUTAS=$(find "$1" -type f -printf '%T@ %p\n' | sort -n -r | cut -f2- -d" ")

	# Número máximo de rutas a guardar en el archivo de registro
	MAX_RUTAS=4

	# Obtener las rutas absolutas más nuevas (hasta MAX_RUTAS)
	RUTAS_NUEVAS=$(echo "$RUTAS" | head -n "$MAX_RUTAS")

	# Agregar las rutas nuevas al archivo de registro "recents.log"
	echo "$RUTAS_NUEVAS" >> recents.log
}

function compara(){

	if [ $# -ne 2 ]; then
	    echo "Se requieren dos argumentos: ruta1 y ruta2"
	    exit 1
	fi

	ruta1=$1
	ruta2=$2
	echo $ruta1
	echo $ruta2
	if [ ! -d "$ruta1" ] || [ ! -d "$ruta2" ]; then
	    echo "Las rutas deben ser archivos válidos"
	    exit 1
	fi

	diff_output=$(diff --brief "$ruta1" "$ruta2")

	if [ -z "$diff_output" ]; then
	    echo "Los archivos son idénticos"
	    exit 0
	else
	    num_differences=$(echo "$diff_output" | wc -l)
	    num_lines_file1=$(wc -l < "$ruta1")
	    percentage_similar=$(bc -l <<< "scale=2; (1 - $num_differences/$num_lines_file1) * 100")
	    echo "El porcentaje de similitud entre los archivos es: $percentage_similar %"
	fi
}

#comptot "comptot1.directori" "comptot2.directori"
#info_ruta "comptot1.directori"
comptot "comptot1.directori" "comptot2.directori"
