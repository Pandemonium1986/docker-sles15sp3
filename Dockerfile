FROM opensuse/leap:15.3

LABEL maintainer="Michael Maffait"
LABEL org.opencontainers.image.source="https://github.com/Pandemonium1986/docker-sles15sp3"

ENV container=docker

# Install openssh and python39
RUN zypper install -y openssh-server \
  python39 && \
  zypper clean --all

WORKDIR "/usr/lib/systemd/system/sysinit.target.wants"

# Install systemd -- See https://hub.docker.com/_/centos/
RUN zypper install -y dbus-1 && \
  systemd-sysvinit && \
  zypper clean --all && \
  for i in *; do [ $i = systemd-tmpfiles-setup.service ] || rm -f $i; done ; \
  rm -f /usr/lib/systemd/system/multi-user.target.wants/* ; \
  rm -f /etc/systemd/system/*.wants/* ; \
  rm -f /usr/lib/systemd/system/local-fs.target.wants/* ; \
  rm -f /usr/lib/systemd/system/sockets.target.wants/*udev* ; \
  rm -f /usr/lib/systemd/system/sockets.target.wants/*initctl* ; \
  rm -f /usr/lib/systemd/system/basic.target.wants/* ; \
  rm -f /usr/lib/systemd/system/anaconda.target.wants/*

WORKDIR /

VOLUME ["/sys/fs/cgroup"]

CMD ["/lib/systemd/systemd"]
