FROM ubuntu:rolling
RUN apt-get update && \ 
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get upgrade -y && \
  apt-get install -y \
  python3 python3-dev python3-pip python3-venv \
  npm git tzdata openssh-server \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /run/sshd
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
  ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata
RUN mkdir -p /venv && \
  python3 -m venv /venv/ && \
  /venv/bin/pip3 install --upgrade pip --no-cache-dir
RUN /venv/bin/pip3 install --no-cache-dir \
    jupyterlab \
    ipywidgets>=7.5 \
    ipython \
    xeus-python
RUN /venv/bin/jupyter labextension install jupyterlab-plotly@4.12.0 @jupyter-widgets/jupyterlab-manager plotlywidget@4.12.0 --no-build && \
  /venv/bin/jupyter labextension install @jupyterlab/debugger --no-build && \
  /venv/bin/jupyter lab build && \
  /venv/bin/jupyter lab clean && \
  /venv/bin/jlpm cache clean && \
  npm cache clean --force && \
  rm -rf $HOME/.node-gyp && \
  rm -rf $HOME/.local
RUN /venv/bin/pip3 install --no-cache-dir \
    plotly \
    pandas \
    xlrd \
    numpy \
    scipy \
    matplotlib \
    scikit-learn \
    tensorflow \
    openpyxl \
    beautifulsoup4 \
    Pillow \
    graphviz \
    lxml \
    python-dateutil \
    pylint \
    requests_html \
    dash \
    dash_daq \
    dash-bootstrap-components \
    gunicorn \
    SQLAlchemy \
    alembic \
    tabulate # to check why it is necessary

  
