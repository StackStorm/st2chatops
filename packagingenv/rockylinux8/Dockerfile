FROM rockylinux:8

RUN yum -y install gcc-c++ make git libicu-devel rpmdevtools

# Install node
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash && \
    source ~/.bashrc && \
    nvm install 20.8.1 && \
    node -v && npm -v

# Install python3 for gyp
RUN yum -y install python3

# Upgrade gyp to a python3 compatible version
RUN source ~/.bashrc && nvm use 20.8.1 && npm install -g node-gyp@latest

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
