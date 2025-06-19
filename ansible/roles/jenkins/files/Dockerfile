FROM jenkins/jenkins:2.504.2-lts-jdk21
COPY --chown=jenkins:jenkins jenkins-plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
USER root
