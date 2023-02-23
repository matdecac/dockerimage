FROM ubuntu:22.10
# initial packages install
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  software-properties-common \
  tzdata locales \
  python3 python3-dev python3-pip python3-venv \
  gcc make git openssh-server curl iproute2 \
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
RUN /venv/bin/pip3 install --upgrade pip --no-cache-dir
# Install jupyterlab and its plotly extension
RUN /venv/bin/pip3 install --no-cache-dir\
    jupyterlab>=3 \
    ipywidgets>=7.6 \
    jupyter-dash \
    ipython \
    ipykernel \
    ptvsd \
    plotly
# install all other required python packages
RUN /venv/bin/pip3 install --no-cache-dir \
    pandas \
    xlrd \
    numpy \
    scipy \
    mako \
    matplotlib \
    scikit-learn \
    openpyxl \
    beautifulsoup4 \
    Pillow \
    graphviz \
    lxml \
    tabulate \
    python-dateutil \
    pylint \
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
    ahrs \
    setuptools \
    gpxpy \
    ipympl \
    scikit-commpy \
    xmltodict \
    kaleido \
    pyproj
# install tools
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y \
  libopenmpi-dev \
  && rm -rf /var/lib/apt/lists/*
# install additional packages for ML
RUN /venv/bin/pip3 install --no-cache-dir \
    cloudpickle~=1.2.1 \
    gym~=0.15.3 \
    ipython \
    joblib \
    matplotlib \
    numpy \
    pandas \
    pytest \
    psutil \
    scipy \
    seaborn==0.8.1 \
    sphinx==1.5.6 \
    sphinx-autobuild==0.7.1 \
    sphinx-rtd-theme==0.4.1 \
    tensorflow>=1.8.0,<2.0
