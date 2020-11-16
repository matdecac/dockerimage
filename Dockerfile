FROM ubuntu:rolling
RUN apt-get update && \ 
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get upgrade -y && \
  apt-get install -y gcc python3 python3-pip python3-venv npm git tzdata && \
  rm -rf /var/lib/apt/lists/* && \
  rm /bin/sh && ln -s /bin/bash /bin/sh && \
  ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  mkdir -p /venv && \
  python3 -m venv /venv/ && \
  /venv/bin/pip3 install --upgrade pip --no-cache-dir && \
  /venv/bin/pip3 install --no-cache-dir \
    numpy \
    pandas \
    sqlalchemy \
    alembic \
    Pillow \
    plotly \
    telepot \
    yfinance \
    alpha_vantage \
    yahoo_fin \
    requests_html \
    scikit-learn \
    tensorflow \
    tabulate \
    dash \
    dash-bootstrap-components \
    gunicorn \
    jupyterlab \
    ipywidgets>=7.5 \
    xeus-python \
    pylint \
    dash \
    dash-bootstrap-components \
    gunicorn && \
  /venv/bin/jupyter labextension install jupyterlab-plotly@4.12.0 @jupyter-widgets/jupyterlab-manager plotlywidget@4.12.0 --no-build && \
  /venv/bin/jupyter labextension install @jupyterlab/debugger --no-build && \
  /venv/bin/jupyter lab build
  
