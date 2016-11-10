FROM ubuntu:xenial
MAINTAINER Susanna Kiwala <ssiebert@wustl.edu>

LABEL \
  version="86" \
  description="VEP image for use in Workflows"

RUN apt-get update && \
    apt-get install -y \
        bioperl \
        wget \
        unzip \
        libfile-copy-recursive-perl \
        libarchive-extract-perl \
        libarchive-zip-perl \
        libapache-dbi-perl \
        curl

RUN mkdir /opt/vep/

WORKDIR /opt/vep
RUN wget https://github.com/Ensembl/ensembl-tools/archive/release/86.zip && \
    unzip 86.zip

WORKDIR /opt/vep/ensembl-tools-release-86/scripts/variant_effect_predictor/
RUN perl INSTALL.pl --NO_HTSLIB

WORKDIR /
RUN ln -s /opt/vep/ensembl-tools-release-86/scripts/variant_effect_predictor/variant_effect_predictor.pl /usr/bin/variant_effect_predictor.pl

ENTRYPOINT ["perl /usr/bin/variant_effect_predictor.pl"]
