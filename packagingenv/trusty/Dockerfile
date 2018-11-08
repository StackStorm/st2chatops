FROM ubuntu:trusty

# Install prerequesties
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential curl devscripts debhelper dh-make git libicu-dev

# Add NodeSource repo
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Install node
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs

RUN apt-get clean

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
