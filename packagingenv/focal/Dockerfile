FROM ubuntu:focal

# Install prerequisites
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential curl gnupg devscripts debhelper dh-make git libicu-dev curl
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install dh-systemd


RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash - && \
    . ~/.bashrc && \
    nvm install 20.8.1 && \
    node -v && npm -v

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
