FROM ubuntu:rolling
RUN apt-get update && \ 
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get upgrade -y && \
  apt-get install -y \
  build-essential cmake libfftw3-dev libpcap-dev gdb \
  python3 python3-dev python3-pip python3-venv \
  npm git tzdata \
  && \
  rm -rf /var/lib/apt/lists/*
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
  ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata
RUN mkdir -p /venv && \
  python3 -m venv /venv/ && \
  /venv/bin/pip3 install --upgrade pip --no-cache-dir && \
  /venv/bin/pip3 install --no-cache-dir \
    plotly \
    dash \
    dash_daq \
    dash-bootstrap-components \
    pandas \
    numpy \
    scipy \
    matplotlib \
    SQLAlchemy \
    alembic \
    dpkt \
    openpyxl \
    beautifulsoup4 \
    gpsd-py3 \
    Pillow \
    ipython \
    h5py \
    graphviz \
    lxml \
    scikit-learn \
    python-dateutil \
    gunicorn \
    jupyterlab \
    ipywidgets>=7.5 \
    xeus-python
RUN /venv/bin/jupyter labextension install jupyterlab-plotly@4.12.0 @jupyter-widgets/jupyterlab-manager plotlywidget@4.12.0 --no-build && \
  /venv/bin/jupyter labextension install @jupyterlab/debugger --no-build && \
  /venv/bin/jupyter lab build && \
  /venv/bin/jupyter lab clean && \
  /venv/bin/jlpm cache clean && \
  npm cache clean --force && \
  rm -rf $HOME/.node-gyp && \
  rm -rf $HOME/.local
  
