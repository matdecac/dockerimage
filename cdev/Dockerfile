FROM matdecac/images:base
RUN apt-get update && \ 
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get upgrade -y && \
  apt-get install -y \
  build-essential cmake gdb libfftw3-dev libpcap-dev \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /venv && \
  python3 -m venv /venv/ && \
  /venv/bin/pip3 install --upgrade pip --no-cache-dir && \
  /venv/bin/pip3 install --no-cache-dir \
    dpkt \
    gpsd-py3 \
    h5py
