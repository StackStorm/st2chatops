FROM centos:8

RUN yum -y install gcc-c++ make git libicu-devel rpmdevtools

# Add NodeSource repo
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash -

# Install development tools
RUN dnf -y module install nodejs:10

# Install python3 for gyp
RUN yum -y install python3 python36-rpm-macros

# Upgrade gyp to a python3 compatible version
RUN npm install -g node-gyp@latest
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
