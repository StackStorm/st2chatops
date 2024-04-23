FROM ubuntu:focal

# Install prerequisites
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential curl gnupg devscripts debhelper dh-make git libicu-dev curl
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install dh-systemd

# Add NodeSource repo
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -

# Install node
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs

RUN apt-get clean
RUN npm install -g npm@6


COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
