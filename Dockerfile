FROM node:alpine

RUN apk update && \
    apk add --no-cache openssl && \
    apk add --no-cache --virtual .build-deps git python make && \
    git clone https://github.com/adam-golab/sonoff-server.git /app && \
    cd /app && \
    npm i && \
    apk del .build-deps && \
    rm -rf /var/apk

COPY docker-entrypoint.sh /

WORKDIR /app    

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["npm", "start"]