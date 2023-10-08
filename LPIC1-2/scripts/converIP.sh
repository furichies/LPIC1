#!/bin/bash
###########################################################################
# Script de Conversión de Dirección IP a Binario                            #
#                                                                         #
# Autor: Ricardo Martínez                                                #
# Correo Electrónico: ricardoinstructor@yandex.com                       #
#                                                                         #
# Este script toma una dirección IP en formato X.X.X.X como argumento,     #
# la descompone en octetos, la convierte a su representación binaria y    #
# luego la muestra con los cuatro octetos binarios separados por puntos.  #
#                                                                         #
# Licencia:                                                               #
# Este script se distribuye bajo los términos de la Licencia Pública        #
# General de GNU versión 2 o posterior (GPL-2+). Puede encontrar una     #
# copia completa de la licencia en el siguiente enlace:                   #
# https://www.gnu.org/licenses/gpl-2.0.html                               #
###########################################################################

# Comprueba si se proporciona un argumento
if [ $# -ne 1 ]; then
  echo "Uso: $0 <dirección_ip>"
  exit 1
fi

# Obtén la dirección IP del argumento
ip=$1
# Expresión regular para verificar si el argumento es una dirección IP válida
ip_regex='^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$'

# Comprueba si la dirección IP coincide con la expresión regular
if ! [[ $ip =~ $ip_regex ]]; then
  echo "El argumento no es una dirección IP válida."
  exit 1
fi
# Utiliza read para dividir la dirección IP en octetos, previamente hay que identificar el . como separador de campos.
IFS='.' read -r -a octetos <<< "$ip"

# Inicializa la variable para almacenar la representación binaria
binario=""

# Convierte cada octeto a binario y lo agrega a la vriable binario
for octeto in "${octetos[@]}"; do
  binario="$binario$(printf "%08d" $(echo "obase=2;$octeto" | bc))"
done

# Imprime la representación binaria con puntos entre octetos. El primer sed toma 8 carcateres y les agrega un punto. El segundo sed quita punto final
ip_bin=$(echo "$binario" | sed 's/.\{8\}/&./g' | sed 's/\.$//')

echo -e "Dirección IPv4:\t\t $1\nConversión binaria:\t$ip_bin"

exit 0

