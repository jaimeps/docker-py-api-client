
# Base
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

# Ubuntu packages and Python pre-requirements
RUN apt-get update -qq \
     && apt-get install -y --no-install-recommends \
        build-essential \
        g++  \
        git  \
        curl  \
        apt-utils \
        python3  \
        python3-dev  \
        python3-pip  \
        python3-setuptools  \
        python3-wheel  \
        python3-tk \
        python3-numpy \
        libopenblas-base  \
        cython3  \
        unixodbc  \
        unixodbc-dev\
        vim

# Python packages
COPY requirements.txt /tmp/
RUN python3 -m pip install -r /tmp/requirements.txt

# Download Google Cloud SDK
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Install gcloud
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding gcloud path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Clean
RUN  apt-get clean \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DEBIAN_FRONTEND teletype

