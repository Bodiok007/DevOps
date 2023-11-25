#!/bin/bash

sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb start

# Wait until MariaDB is up and running
until nc -z localhost 3306; do
    echo "Waiting for MariaDB to start to perform variable initialization..."
    sleep 1
done

service mariadb status

# Check if environment variables are set
if [ -s "$MYSQL_ROOT_PASSWORD_FILE" ]; then
    MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
    echo "Configuring MySQL root password..."

    mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"
fi

if [ -s "$MYSQL_DATABASE_FILE" ]; then
    MYSQL_DATABASE=$(cat "$MYSQL_DATABASE_FILE")
    echo "Creating database: $MYSQL_DATABASE"

    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE \`$MYSQL_DATABASE\`;"
fi

if [ -n "$MYSQL_USER_FILE" ] && [ -n "$MYSQL_PASSWORD_FILE" ]; then
    # Create a user and grant privileges
    MYSQL_USER=$(cat "$MYSQL_USER_FILE")
    MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
    echo "Creating user: $MYSQL_USER with password: $MYSQL_PASSWORD"
    
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
fi

service mariadb stop

until ! pgrep mariadb; do
    echo "Waiting for MariaDB to stop..."
    sleep 1
done

echo "MariaDB has stopped. Proceeding with the next steps."

# Start the original entry point (MariaDB)
exec "$@"


