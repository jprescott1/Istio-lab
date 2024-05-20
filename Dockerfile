FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

# Do not add more stuff to this list that isn't small or critically useful.
# If you occasionally need something on the container do
# sudo apt-get update && apt-get whichever

# hadolint ignore=DL3005,DL3008
RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  ca-certificates \
  curl \
  iptables \
  iproute2 \
  iputils-ping \
  knot-dnsutils \
  netcat-openbsd \
  tcpdump \
  conntrack \
  bsdmainutils \
  net-tools \
  lsof \
  sudo \
  && update-ca-certificates \
  && apt-get upgrade -y \
  && apt-get clean \
  && rm -rf  /var/log/*log /var/lib/apt/lists/* /var/log/apt/* /var/lib/dpkg/*-old /var/cache/debconf/*-old \
  && update-alternatives --set iptables /usr/sbin/iptables-legacy \
  && update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# Sudoers used to allow tcpdump and other debug utilities.
RUN useradd -m --uid 1337 istio-proxy && \
  echo "istio-proxy ALL=NOPASSWD: ALL" >> /etc/sudoers