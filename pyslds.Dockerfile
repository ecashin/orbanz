FROM python:3.6-stretch

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
  future \
  ipython \
  numpy \
  pandas \
  plotly \
  pytest \
  scipy scikit-learn \
  torch torchvision

# needs future installed beforehand
RUN pip install pyslds

EXPOSE 8000