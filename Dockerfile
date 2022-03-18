FROM centos:7
ARG TARANTOOL_VERSION=2.8
ARG TARANTOOL_WORKDIR="/app"
RUN curl -L https://tarantool.io/installer.sh | VER=$TARANTOOL_VERSION /bin/bash -s -- --repo-only && \
    yum -y install cmake make gcc gcc-c++ git unzip tarantool tarantool-devel cartridge-cli && \
    yum clean all

WORKDIR $TARANTOOL_WORKDIR
CMD cartridge version

EXPOSE 8081 3301
