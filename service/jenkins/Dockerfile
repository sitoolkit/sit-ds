ARG VERSION
FROM jenkins/jenkins:${VERSION}

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false \
      -Dhudson.model.DirectoryBrowserSupport.CSP=\"sandbox allow-scripts allow-popups;\"" \
    JENKINS_OPTS=--prefix=/jenkins

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/

RUN set -eux \
  && usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
