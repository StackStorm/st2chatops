FROM rockylinux:8

RUN yum -y install gcc-c++ make git libicu-devel rpmdevtools

# Install node
RUN yum -y module install nodejs:20

# Install python3 for gyp
RUN yum -y install python3

# Upgrade gyp to a python3 compatible version
RUN npm install -g node-gyp@latest

# Downgrade npm
RUN npm install -g npm@6

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
