FROM rockylinux:8

RUN yum -y install gcc-c++ make git libicu-devel rpmdevtools

# Add NodeSource repo
#RUN curl --silent --location https://rpm.nodesource.com/setup_20.x | bash -

# Install node
RUN yum -y module install nodejs:20
RUN node --version

# Install python3 for gyp
RUN yum -y install python3

# Upgrade gyp to a python3 compatible version
RUN npm install -g node-gyp@latest

# Install development tools
#RUN yum -y install nodejs:20.1.1

# Downgrade npm
RUN npm install -g npm@6

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
