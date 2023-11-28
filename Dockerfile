FROM opensuse/leap:15.3

LABEL maintainer="Michael Maffait"
LABEL org.opencontainers.image.source="https://github.com/Pandemonium1986/docker-centos7"

ENV container=docker

# Install systemd -- See https://hub.docker.com/_/centos/
WORKDIR /lib/systemd/system/sysinit.target.wants/
RUN (for i in *; do [ "$i" = systemd-tmpfiles-setup.service ] || rm -f "$i"; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;

WORKDIR /

# Install dependencies.
# RUN yum -y install epel-release && \
#   yum -y install \
#   openssh-server \
#   python-pip && \
#   yum clean all

# ENV LC_ALL en_US.UTF-8
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US.UTF-8
# ENV PYTHONIOENCODING utf8


VOLUME ["/sys/fs/cgroup"]

CMD ["/lib/systemd/systemd"]
