#!/bin/ash
set -e

if [ ! -f "/app/certs/cert.pem" ]; then
    echo "Generate TLS certificate..." 
    openssl req -x509 -newkey rsa:2048 -keyout /app/certs/keytmp.pem -out /app/certs/cert.pem -days 365 -nodes -subj "/C=NZ/L=Auckland/O=SonoffServer/OU=DevOps/CN=www.example.com/emailAddress=dev@www.example.com" && \
    openssl rsa -in /app/certs/keytmp.pem -out /app/certs/key.pem && \
    rm /app/certs/keytmp.pem
fi

exec "$@"