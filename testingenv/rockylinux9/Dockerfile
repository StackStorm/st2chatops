FROM rockylinux:9

# Add NodeSource repo
#RUN curl --silent --location https://rpm.nodesource.com/setup_20.x | bash -

# Install development tools
RUN yum -y module install nodejs:20

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
