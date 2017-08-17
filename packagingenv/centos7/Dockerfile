FROM centos:7

# Add NodeSource repo
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -

# Install development tools
RUN yum -y install nodejs gcc-c++ make git libicu-devel rpmdevtools

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
