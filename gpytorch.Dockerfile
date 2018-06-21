FROM python:3.6.5-stretch

COPY . /context

RUN /context/scripts/create-user.sh

RUN apt-get update && apt-get install -y \
  aufs-tools \
  automake \
  build-essential \
  curl \
  dpkg-sig \
  ed \
  less \
  man \
  sudo \
  tmux \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
  pip install \
  click \
  flake8 \
  git+https://github.com/cornellius-gp/gpytorch.git \
  ipython \
  jupyter \
  numpy \
  pandas \
  plotly \
  pytest \
  scipy scikit-learn \
  torch torchvision

EXPOSE 8000