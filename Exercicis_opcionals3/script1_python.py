#!/usr/bin/env python3

#Escriu un script python que rebi tres paràmetres:
        #script1_python.py nomfitxer user|group|others r|w|x

#El fitxer contindrà el resultat d'un "ls -l" (bash).

#L'script llegirà aquest fitxer i en posarà el contingut a una llista de tuples.

#Les tuples contindran el primer i darrer element de cada línia (permisos,filename).

#Després farà un bucle recorrent la llista i cridant a la funció:
        #test_perms(tupla, qui, perm), on qui= user|group|others i perm= r|w|x

#Aquesta comprovarà si el fitxer que hi ha a la tupla té activat el tipus 'perm' per a l'àmbit 'qui'. Si és així, ho mostrarà per pantalla.




import sys

def test_perms(tupla, qui, perm):
    #Funció que comprova si el fitxer té el permís 'perm' per a l'àmbit 'qui'"""
    #print (tupla)
    #print (qui)
    #print (perm)
    permisos, nomfitxer = tupla
    permisos_dict = {'r':1, 'w':2, 'x':3}
    qui_dict = {'user':0, 'group':3, 'others':6}
    perm_index = permisos_dict[perm]
    qui_index = qui_dict[qui]
    if permisos[qui_index+perm_index] == perm:
        print(f"El fitxer {nomfitxer} té el permís {perm} per a l'àmbit {qui}")

# Comprovem que s'hagin passat els paràmetres correctes
if len(sys.argv) != 4:
    print("Ús: script1_python.py nomfitxer user|group|others r|w|x")
    sys.exit(1)

# Obtenim els paràmetres
nomfitxer = sys.argv[1]
qui = sys.argv[2]
perm = sys.argv[3]

# Llegim el fitxer i posem el contingut a una llista de tuples
with open(nomfitxer, 'r') as f:
    contingut = f.readlines()
llista_tuples = []
for linia in contingut:
    linia = linia.strip()
    camps = linia.split()
    permisos = camps[0]
    nomfitxer = camps[-1]
    llista_tuples.append((permisos, nomfitxer))

# Recorrem la llista i cridem a la funció test_perms
for tupla in llista_tuples:
    test_perms(tupla, qui, perm)

