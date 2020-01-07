FROM centos:8

RUN yum -y install gcc-c++ make git libicu-devel rpmdevtools

RUN yum -y update

# Install development tools
RUN dnf -y module install nodejs:10

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
