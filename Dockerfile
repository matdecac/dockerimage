FROM ubuntu:24.04
# initial packages install
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get dist-upgrade -y \
  && apt-get install -y \
  ca-certificates dpkg-dev \
  && rm -rf /var/lib/apt/lists/*
