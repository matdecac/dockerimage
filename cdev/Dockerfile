FROM matdecac/images:jupyterbase
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y \
  build-essential cmake gdb \
  graphviz doxygen \
  libfftw3-dev libpcap-dev \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /venv \
  && python3 -m venv /venv/ \
  && /venv/bin/pip3 install --upgrade pip --no-cache-dir \
  && /venv/bin/pip3 install --no-cache-dir \
    dpkt \
    gpsd-py3 \
    h5py
RUN export DEBIAN_FRONTEND=noninteractive \
  && add-apt-repository -y ppa:ettusresearch/uhd \
  && apt-get update \
  && apt-get install -y \
  libboost-all-dev libuhd-dev uhd-host libuhd3.15.0 \
  && rm -rf /var/lib/apt/lists/*
