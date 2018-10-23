FROM centos:7

RUN yum -y install gcc-c++ make git libicu-devel rpmdevtools

# Add NodeSource repo
RUN curl --silent --location https://rpm.nodesource.com/setup_9.x | bash -

# Install development tools
RUN yum -y install nodejs

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
