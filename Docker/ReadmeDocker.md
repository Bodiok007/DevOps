# Docker

## Structure

1. `WebDockerfile` - to create web image based on [wordpress:php8.2-apache](https://hub.docker.com/layers/library/wordpress/php8.2-apache/images/sha256-0d4b5901a259a565595d1c48c40a34b2425c544cd3b26b6a5ebc9ddd39be29b7?context=explore).
2. `DBDockerfile` - to create db image based on [ubuntu:jammy](http://sabaka.net](https://hub.docker.com/layers/library/ubuntu/jammy/images/sha256-c9cf959fd83770dfdefd8fb42cfef0761432af36a764c077aed54bbc5bb25368?context=explore)https://hub.docker.com/layers/library/ubuntu/jammy/images/sha256-c9cf959fd83770dfdefd8fb42cfef0761432af36a764c077aed54bbc5bb25368?context=explore). Uses [MariaDB](https://mariadb.org/).
3. `init_db_from_env.sh` - script to initialize mysql environment variables.
4. `secrets` - folder where exist values for mysql environment variables.
5. `docker-compose.yaml` - to run web and db containers with a single command.

#### `WebDockerfile`

- Exposes port: `80`.  
- Command to build web image: `docker build -t web -f WebDockerfile .`.  
- Create network before running container if not exist: `docker network create my_network`.  

Run web container:  
```
docker run -d \
  --name web-container \
  --network my_network \
  -e WORDPRESS_DB_HOST=db-container \
  -e WORDPRESS_DB_NAME=wordpress \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppassword \
  -p 8080:80 \
  web
```

#### `DBDockerfile`

- Exposes port: `3306`.  
- Command to build db image: `docker build -t db -f DbDockerfile .`
- Create network before running container if not exist: `docker network create my_network`.  

Run db container:
```
docker run -d \
  --name db-container \
  --network my_network \
  -e MYSQL_DATABASE_FILE=/run/secrets/database-name \
  -e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/database-password-root \
  -e MYSQL_USER_FILE=/run/secrets/database-user \
  -e MYSQL_PASSWORD_FILE=/run/secrets/database-password \
  -v ./secrets:/run/secrets:ro \
  -p 3306:3306 \
  db
```

#### `secrets`

Folder that contains next files with related values inside:
- database-name
- database-password
- database-password-root
- database-user

Values can be changed to whatever you need.

#### `docker-compose.yaml`
To run containers: `docker-compose up`.  
To remove everything created by docker compose: `docker-compose down`.

## Build and run

### Preconditions

1. Build images:
   - `docker build -t db -f DbDockerfile .`
   - `docker build -t web -f WebDockerfile .`

#### By using docker files

**NOTE:** The `db` container should be started before the `web` container.

1. Create network:
   - `docker network create my_network`
2. Rub `db` container:
```
docker run -d \
  --name db-container \
  --network my_network \
  -e MYSQL_DATABASE_FILE=/run/secrets/database-name \
  -e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/database-password-root \
  -e MYSQL_USER_FILE=/run/secrets/database-user \
  -e MYSQL_PASSWORD_FILE=/run/secrets/database-password \
  -v ./secrets:/run/secrets:ro \
  -p 3306:3306 \
  db
```
3. Run `web` container:
```
docker run -d \
  --name web-container \
  --network my_network \
  -e WORDPRESS_DB_HOST=db-container \
  -e WORDPRESS_DB_NAME=wordpress \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppassword \
  -p 8080:80 \
  web
```
**NOTE:** `WORDPRESS_DB_NAME`, `WORDPRESS_DB_USER` and `WORDPRESS_DB_PASSWORD` must be the same as in the related `secrets` files.

4. Open `localhost:8080` in browser to test if works.

#### By using docker compose

Just execute: `docker-compose up`.

## Clean up

#### For docker files

1. Stop containers:
   - `docker stop db-container`
   - `docker stop web-container`
2. Remove containers:
   - `docker rm db-container`
   - `docker rm web-container`
3. Remove network:
   - `docker network rm my_network`

#### For docker compose

Just execute: `docker-compose down -v`.

### Remove images

- `docker rmi db`
- `docker rmi web`
