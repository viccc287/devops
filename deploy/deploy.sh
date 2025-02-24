#!/bin/bash
# Definir variables
REPO_URL="https://github.com/viccc287/devops"
APP_DIR="/var/www/astro"

# Apagar NGINX y NGROK
sudo systemctl stop nginx
pkill -f ngrok

# Navegar al directorio de la aplicación y actualizar el código
echo "Actualizando el código desde el repositorio..."
cd "$APP_DIR" || exit
git init
git remote remove origin 2>/dev/null
git remote add origin "$REPO_URL"
git fetch --depth=1 origin

# Extraer solo el contenido de la carpeta hostear/dist a la raíz del directorio de la aplicación
git checkout FETCH_HEAD -- hostear/dist
rsync -a hostear/dist/ ./
rm -rf hostear/dist

# Encender NGINX
echo "Iniciando NGINX..."
sudo systemctl start nginx

# Iniciar NGROK y obtener la URL
echo "Iniciando NGROK..."
nohup ngrok http 192.168.0.18:3000 > /dev/null 2>&1 &
sleep 5 # Esperar a que NGROK genere la URL

# Obtener la URL pública de NGROK
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r .tunnels[0].public_url)

echo "Aplicación actualizada y accesible en: $NGROK_URL"