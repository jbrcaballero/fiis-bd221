# Comandos Postgres
Presentamos una lista de comandos que pueden utilizar para inicializar su cluster de Postgres (principalmente para instalaciones locales):

## Inicializar el cluster (solo la primera vez)
Sobre la carpeta *bin* de su instalación de Postgres, ejecute el siguiente comando:

    initdb -D ../data -E UTF8 -U postgres -W

Este código inicializa un cluster en el subdirectorio *data* de la carpeta de Postgres (el archivo zip provisto ya tiene esta carpeta creada). Utiliza UTF8 como encoding (para evitar problemas con caracteres como tildes y *ñ*), el superusuario será *postgres* y con el parámetro *W* hacemos que nos solicite un password para este usuario en la ejecución del comando.

## Iniciar el servidor

Utilizaremos *pg_ctl* para poder iniciar el servidor. Debemos especificar la ruta asociada a nuestro cluster (la misma que utilizamos para inicializar)

    pg_ctl start -D ../data


## Detener el servidor
De manera análoga, se realiza de esta forma

    pg_ctl stop -D ../data


## Creación de Base de Datos
En el cluster que hemos inicializado podemos crear varias bases de datos. Realizamos la creación una base de datos con el siguiente comando (podemos ejecutarlo desde *psql*, *pgadmin* u otra herramienta cliente):

    CREATE DATABASE fiis_dbd;



Es recomendable crear un usuario para poder manejar esta base de datos. Podemos hacerlo de la siguiente forma:

    CREATE USER usuario WITH ENCRYPTED PASSWORD 'password';


Damos los privilegios en la base de datos para el usuario creado:

    GRANT ALL PRIVILEGES ON DATABASE fiis_dbd211 TO usuario;
