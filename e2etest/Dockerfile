ARG VERSION
FROM mcr.microsoft.com/playwright:${VERSION}

RUN apt update \
  && apt install nginx -y\
  && rm -rf /var/lib/apt/lists/*

COPY server.conf /etc/nginx/conf.d/server.conf

WORKDIR /mnt
ENTRYPOINT npm i && nginx -g 'daemon off;'
