FROM centos:8
RUN yum -y install libicu-devel python3
# Add NodeSource repo
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash -

# Install development tools
#RUN yum -y install nodejs
RUN yum -y module install nodejs:10

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
