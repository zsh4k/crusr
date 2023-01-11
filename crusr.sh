#!/bin/bash

# Verificar si el script se esta ejecutando como root
if [ "$(id -u)" != "0" ]; then
   echo "Este script debe ser ejecutado como root" 1>&2
   exit 1
fi

# Pide el nombre del nuevo usuario
echo "Ingrese el nombre del nuevo usuario:"
read new_user

# Verifica si ya se ha instalado el paquete sudo
if dpkg -s "sudo" > /dev/null 2>&1; then
    echo "sudo ya esta instalado."
else
    # Instala el paquete sudo
    apt install sudo
fi

# Verifica si el nuevo usuario ya existe
if id -u "$new_user" > /dev/null 2>&1; then
    echo "$new_user ya existe."
else
    # Agrega el nuevo usuario
    adduser $new_user
fi

# Agrega el nuevo usuario al grupo sudo
adduser $new_user sudo

# Cambia a la cuenta del nuevo usuario
su - $new_user

