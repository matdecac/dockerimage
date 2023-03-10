FROM nvidia/cuda:12.0.1-base-ubuntu18.04
# initial packages install
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  software-properties-common \
  tzdata locales bash-completion \
  python3.7 python3.7-dev python3-pip python3.7-venv python3.7-distutils \
  gcc make git openssh-server curl \
  libopenmpi-dev \
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
  && python3.7 -m venv /venv/
# define env path for python
RUN echo "PATH=/venv/bin:$PATH" > /etc/profile.d/python_venv.sh
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH="/venv/lib/python3.7/site-packages:$PYTHONPATH"
ENV PYTHONPATH="/venv/lib/python3.7/site-packages:/usr/local/lib/python3.7/site-packages:$PYTHONPATH"

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y \
  libosmesa6-dev libgl1-mesa-glx libglfw3 libglew-dev \
  && rm -rf /var/lib/apt/lists/*
RUN /venv/bin/pip3 install --upgrade pip --no-cache-dir
# Install jupyterlab and its plotly extension
RUN /venv/bin/pip3 install --no-cache-dir\
    jupyterlab>=3 \
    ipywidgets>=7.6 \
    jupyter-dash \
    ipython \
    ipykernel \
    ptvsd \
    plotly \
    pylint \
    pandas \
    xlrd \
    numpy \
    scipy \
    kaleido \
    matplotlib \
    scikit-learn \
    mako \
    openpyxl \
    Pillow \
    graphviz \
    lxml \
    tabulate \
    python-dateutil \
    requests \
    requests_html \
    SQLAlchemy \
    alembic \
    h5py \
    pyserial \
    setuptools \
    gpxpy \
    ipympl \
    xmltodict \
    "cloudpickle~=1.2.1" \
    "gym~=0.15.3" \
    joblib \
    pytest \
    psutil \
    torch \
    "seaborn==0.8.1" \
    "sphinx==1.5.6" \
    "sphinx-autobuild==0.7.1" \
    "sphinx-rtd-theme==0.4.1" \
    "tensorflow>=1.8.0,<2.0" \
    "protobuf<=3.20" \
    "mujoco-py<2.2,>=2.1"

# Install jupyterlab and its plotly extension
RUN /venv/bin/pip3 install --no-cache-dir\
    mpi4py \
    spinup
