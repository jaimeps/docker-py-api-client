
# Base
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

# Ubuntu packages and Python pre-requirements
COPY requirements_1.txt requirements_2.txt /tmp/
RUN apt-get update -qq \
    && xargs -a /tmp/requirements_1.txt apt-get install -y --no-install-recommends

# Python packages
RUN python3 -m pip install -r /tmp/requirements_2.txt

# Download Google Cloud SDK
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Install gcloud
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding gcloud path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Cloud SQL proxy
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy 
RUN chmod +x cloud_sql_proxy

# Clean
RUN  apt-get clean \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DEBIAN_FRONTEND teletype

