FROM ubuntu:bionic

# Install prerequesties
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && apt-get update && \
    apt-get -y install curl gnupg

# Add NodeSource repo
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

# Install node
# NOTE: We need to explicitly specify a version so it uses NodejS from the
# correct node source repo and not from the upstream Ubuntu one
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install "nodejs=6.14.1-1nodesource1"


COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
