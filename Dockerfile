
# Base
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

# Ubuntu packages
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
        libopenblas-base  \
        cython3  \
        unixodbc  \
        unixodbc-dev\
        vim

# Python packages
COPY requirements.txt /tmp/
RUN python3 -m pip install -r /tmp/requirements.txt

# Clean
RUN  apt-get clean \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DEBIAN_FRONTEND teletype

