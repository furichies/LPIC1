#!/bin/bash
###########################################################################
# Script de Conversión de formato CIDR a decimal                            #
#                                                                         #
# Autor: Ricardo Martínez                                                #
# Correo Electrónico: ricardoinstructor@yandex.com                       #
#                                                                         #
# Este script toma un valor de número de bits (notación cIDR) y devuelve  #
# el formato clásico x.x.x.x                                                                       #
# Licencia:                                                               #
# Este script se distribuye bajo los términos de la Licencia Pública        #
# General de GNU versión 2 o posterior (GPL-2+). Puede encontrar una     #
# copia completa de la licencia en el siguiente enlace:                   #
# https://www.gnu.org/licenses/gpl-2.0.html                               #
###########################################################################

# Comprueba si se proporciona un argumento
if [ $# -ne 1 ]; then
  echo "Uso: $0 <CIDR>"
  exit 1
fi

# Obtiene el valor CIDR del argumento
cidr=$1

# Verifica si el valor CIDR es válido (entre 0 y 32)
if [ $cidr -lt 0 ] || [ $cidr -gt 32 ]; then
  echo "El valor CIDR debe estar en el rango de 0 a 32."
  exit 1
fi

# Función para convertir un número decimal a binario de 32 bits
decimal_to_binary() {
  local num="$1"
  local binary=""
  for (( i=0; i<32; i++ )); do
    bit=$(( (num >> (31 - i)) & 1 ))
    binary="${binary}${bit}"
  done
  echo "$binary"
}

# Calcula la máscara de red en formato octetos
mask_octets=""
for (( i=0; i<4; i++ )); do
  if [ $cidr -ge 8 ]; then
    mask_octets="${mask_octets}255"
    cidr=$((cidr - 8))
  else
    mask_octets="${mask_octets}$((256 - 2**(8-cidr)))"
    cidr=0
  fi
  [ $i -lt 3 ] && mask_octets="${mask_octets}."
done



# Imprime la máscara de red en formato octetos y binario
echo "Máscara de Red en formato octetos: $mask_octets"

exit 0

