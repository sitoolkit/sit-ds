ARG VERSION
FROM jenkins/jenkins:${VERSION}

ENV JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true"

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false \
  -Dhudson.model.DirectoryBrowserSupport.CSP=\"default-src 'self'; script-src * 'unsafe-inline'; style-src * 'unsafe-inline'; img-src *; child-src 'self'; sandbox allow-same-origin allow-scripts;  font-src *;\"" \
  JENKINS_OPTS=--prefix=/jenkins

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER root

RUN curl -sL https://deb.nodesource.com/setup_14.x
RUN apt-get update
RUN apt-get -y install nodejs
RUN apt-get -y install npm
RUN npm install -g newman
RUN npm install -g newman-reporter-htmlextra