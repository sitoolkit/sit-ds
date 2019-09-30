FROM ubuntu:latest

RUN set -eux \
    && : "Install wget" \
    && apt-get update -y \
    && apt-get install -y wget gnupg \
    && : "Install Chrome" \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get -y update \
    && apt-get -y install --no-install-recommends google-chrome-stable \
    && : "Install JDK11" \
    && apt-get -y install --no-install-recommends openjdk-11-jre-headless \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./mvnw", "verify", "-DbaseUrl=http://host.docker.internal"]

# Usage
# docker run --rm -w /mnt --mount type=bind,src=$(pwd)/e2etest,dst=/mnt --mount type=bind,src=${HOME}/.m2,dst=/root/.m2 sit-e2e -DuserId=user001 -Dpassword=password
