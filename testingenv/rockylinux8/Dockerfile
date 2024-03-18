FROM rockylinux:8

# Add NodeSource repo
RUN curl --silent --location https://rpm.nodesource.com/setup_20.x | bash -

# Install development tools
RUN yum -y install nodejs

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
