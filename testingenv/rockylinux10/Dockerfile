FROM rockylinux:10

# Install development tools
RUN yum -y module install nodejs:20 

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
