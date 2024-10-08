FROM ubuntu:24.04
# initial packages install
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get dist-upgrade -y \
  && apt-get install -y \
  software-properties-common \
  tzdata locales bash-completion \
  python3 python3-dev python3-pip python3-venv \
  gcc make git openssh-server curl iproute2 \
  nano bash-completion \
  build-essential cmake gdb valgrind \
  lcov gcovr \
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
ENV PYTHONPATH="/venv/lib/python3.12/site-packages:$PYTHONPATH"
ENV PYTHONPATH="/venv/lib/python3.12/site-packages:/usr/local/lib/python3.12/site-packages:$PYTHONPATH"
#COPY pip.conf /root/.config/pip/pip.conf
RUN /venv/bin/pip3 install --upgrade pip --no-cache-dir
# Install pythons extensions
RUN /venv/bin/pip3 install --no-cache-dir \
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
    pyproj \
    pymap3d \
    simplekml \
    python-docx \
    coverage
