FROM centos:6

RUN yum -y install gcc-c++ make git libicu-devel rpmdevtools

RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo && \
    yum -y install devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++

ENV CC  /opt/rh/devtoolset-2/root/usr/bin/gcc
ENV CPP /opt/rh/devtoolset-2/root/usr/bin/cpp
ENV CXX /opt/rh/devtoolset-2/root/usr/bin/c++

# Add NodeSource repo
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash -

# Install development tools
RUN yum -y install nodejs

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
