FROM ubuntu:22.10
# initial packages install
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  software-properties-common \
  tzdata locales bash-completion \
  python3 python3-dev python3-pip python3-venv \
  gcc make git openssh-server curl iproute2 \
  build-essential cmake gdb valgrind \
  graphviz doxygen \
  libfftw3-dev libpcap-dev tshark \
  && rm -rf /var/lib/apt/lists/*
# replace SH with BASH
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# Locales gen
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && export LC_ALL="fr_FR.UTF-8" \
  && export LC_CTYPE="fr_FR.UTF-8" \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen \
  && dpkg-reconfigure --frontend noninteractive locales
# SSH run folder
RUN mkdir -p /run/sshd
# create python venv
RUN mkdir -p /venv \
  && python3 -m venv /venv/
RUN echo "PATH=/venv/bin:$PATH" > /etc/profile.d/python_venv.sh
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH="/venv/lib/python3.10/site-packages:$PYTHONPATH"
ENV PYTHONPATH="/venv/lib/python3.10/site-packages:/usr/local/lib/python3.10/site-packages:$PYTHONPATH"
RUN /venv/bin/pip3 install --upgrade pip --no-cache-dir
# Install jupyterlab and its plotly extension
RUN /venv/bin/pip3 install --no-cache-dir\
    jupyterlab>=3 \
    ipywidgets>=7.6 \
    jupyter-dash \
    ipython \
    ipykernel \
    ptvsd \
    pylint \
    plotly \
    pandas \
    xlrd \
    numpy \
    scipy \
    mako \
    matplotlib \
    scikit-learn \
    scikit-commpy \
    openpyxl \
    beautifulsoup4 \
    Pillow \
    graphviz \
    lxml \
    tabulate \
    python-dateutil \
    requests \
    requests_html \
    dash \
    dash_daq \
    dash-bootstrap-components \
    gunicorn \
    SQLAlchemy \
    alembic \
    dpkt \
    gpsd-py3 \
    h5py \
    pyserial \
    setuptools \
    gpxpy \
    ipympl \
    xmltodict \
    kaleido \
    pyproj
# ---------------------------------------------------
# install additionnal linux packages for USRP support
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y \
  autoconf automake ccache cpufrequtils ethtool \
  g++ inetutils-tools libboost-all-dev libncurses5 libncurses5-dev libusb-1.0-0 libusb-1.0-0-dev \
  libusb-dev python3-dev \
  ruamel.yaml \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir uhd && cd uhd && git clone https://github.com/EttusResearch/uhd.git
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH="/venv/lib/python3.10/site-packages:$PYTHONPATH"
RUN cd uhd/uhd/host && mkdir build && cd build && cmake -DCMAKE_FIND_ROOT_PATH=/usr -DENABLE_PYTHON_API=ON .. && make -j12
RUN cd uhd/uhd/host/build && make install && ldconfig
ENV PYTHONPATH="/venv/lib/python3.10/site-packages:/usr/local/lib/python3.10/site-packages:$PYTHONPATH"

RUN mkdir -p /usr/local/lib/python3.10/site-packages
RUN mv /usr/local/local/lib/python3.10/dist-packages/uhd /usr/local/lib/python3.10/site-packages/uhd
RUN mv /usr/local/local/lib/python3.10/dist-packages/usrp_mpm /usr/local/lib/python3.10/site-packages/usrp_mpm
# ---------------------------------------------------

