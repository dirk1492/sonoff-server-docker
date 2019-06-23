FROM node:alpine

RUN apk update && \
    apk add --no-cache openssl && \
    apk add --no-cache --virtual .build-deps git python make && \
    git clone https://github.com/adam-golab/sonoff-server.git /app && \
    cd /app && \
    npm i && \
    npm audit fix && npm audit fix && \
    npm install pm2 -g && \
    chown -R node /app && \
    apk del .build-deps && \
    rm -rf /var/apk

COPY docker-entrypoint.sh /

WORKDIR /app    

EXPOSE 8080
EXPOSE 8090

USER node

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["pm2-runtime", "index.js"]