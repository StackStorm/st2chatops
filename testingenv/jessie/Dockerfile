FROM debian:jessie

# Install prerequesties
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install curl

# Add NodeSource repo
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -

# Install node
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install nodejs

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
