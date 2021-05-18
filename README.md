# Práctica 15

## Instalación de WordPress usando contenedores Docker y Docker Compose

Primero instalamos Docker y Docker Compose desde apt:

```
apt install docker -y
apt install docker-compose -y
```

Una vez instalado docker no está habilitado, por lo que lo tendremos que habilitar con systemctl:

```
systemctl enable docker
systemctl start docker
```

El comando que lanzará los contenedores con Docker Compose es el siguiente:

`docker-compose up -d`

Este comando ejecuta el archivo docker-compose.yml que hemos creado previamente con los contenedores. Dentro del archivo encontramos lo siguiente:

- El contenedor de mysql en el puerto 3306. Las variables están en el archivo .env por lo que hay que llamarlas con esta estructura ${...}:

    ```
    mysql:
    image: mysql
    command: --default-authentication-plugin=mysql_native_password
    ports: 
     - 3306:3306
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=${MYSQL_DATABASE}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - backend-network
    restart: always
    ```

- El contenedor de phpMyAdmin en el puerto 80 pero redirigido al 8080:

    ```
    phpmyadmin:
    image: phpmyadmin
    ports: 
     - 8080:80
    environment:
      - PMA_ARBITRARY=1
    networks:
      - backend-network
      - frontend-network
    restart: always
    ```

- El contenedor de Wordpress en el puerto 80. Las variables están en el archivo .env:

    ```
    wordpress:
    image: wordpress
    ports: 
     - 80:80
    environment:
      - WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME}
      - WORDPRESS_DB_USER=${WORDPRESS_DB_USER}
      - WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}
    volumes:
      - wordpress_data:/var/www/html
    networks:
      - backend-network
      - frontend-network
    restart: always
    ```

- Al final del archivo se declaran los volúmenes de los contenedores que los han necesitado, en nuestro caso mysql y wordpress, junto a las redes que vamos a usar:

    ```
    volumes:
     mysql_data:
     wordpress_data:

    networks:
    backend-network:
    frontend-network:
    ```