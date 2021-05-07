#!/bin/bash

#------------------------------------------------------------------------
# Instalación de Docker
#------------------------------------------------------------------------

# Habilitamos el modo de shell para mostrar los comandos que se ejecutan
set -x

# Actualizamos la lista de paquetes
apt update -y

# Actualizamos los paquetes que lo necesiten
apt upgrade -y

# Descargamos los repositorios necesarios
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Descargamos la clave GPG
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Establecemos el repositorio
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Empezamos la descarga del motor de docker
apt-get install docker-ce docker-ce-cli containerd.io -y

# Este comando verifica la instalación de docker
docker run hello-world

#------------------------------------------------------------------------
# Instalación de Docker Compose
#------------------------------------------------------------------------

# Descargamos la última version de Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Asignamos permisos de ejecución al archivo
chmod +x /usr/local/bin/docker-compose