FROM ubuntu:xenial

# Install prerequesties
RUN apt-get clean && apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install curl

# Add NodeSource repo
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -

# Install node
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
