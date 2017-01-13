FROM ubuntu:xenial
MAINTAINER Susanna Kiwala <ssiebert@wustl.edu>

LABEL \
  version="87" \
  description="VEP image for use in Workflows"

RUN apt-get update && \
    apt-get install -y \
        git \
        bioperl

RUN mkdir /opt/vep/

WORKDIR /opt/vep
RUN git clone https://github.com/Ensembl/ensembl-vep.git --branch release/87 --single-branch

WORKDIR /opt/vep/ensembl-vep
RUN perl INSTALL.pl --NO_HTSLIB

WORKDIR /
RUN ln -s /opt/vep/ensembl-vep/scripts/variant_effect_predictor/vep.pl /usr/bin/vep.pl

ENTRYPOINT ["/usr/bin/perl", "/usr/bin/vep.pl"]
