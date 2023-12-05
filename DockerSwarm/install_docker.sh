#!/bin/bash

# Оновлення пакетів
sudo apt update

# Встановлення необхідних залежностей
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Додавання ключа GPG для офіційних репозиторіїв Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Додавання офіційного репозиторію Docker
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Оновлення пакетів після додавання репозиторію Docker
sudo apt update

# Встановлення Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Додавання поточного користувача до групи docker, щоб уникнути використання sudo при виклику команд Docker
sudo usermod -aG docker $USER

# Встановлення Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose