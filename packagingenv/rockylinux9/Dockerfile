FROM rockylinux:9

RUN yum -y install make git rpmdevtools

RUN yum -y install systemd-rpm-macros

# Install node (bundled npm 11 reads .npmrc's supply-chain settings); no native modules to compile
RUN yum -y module enable nodejs:24 && yum -y install nodejs npm
RUN node --version && npm --version

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
