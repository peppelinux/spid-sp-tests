# Copyright 2021 Paolo Smiraglia <paolo.smiraglia@gmail.com>
#
# Licensed under the EUPL, Version 1.2 or - as soon they will be approved by
# the European Commission - subsequent versions of the EUPL (the "Licence").
#
# You may not use this work except in compliance with the Licence.
#
# You may obtain a copy of the Licence at:
#
#    https://joinup.ec.europa.eu/software/page/eupl
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# Licence for the specific language governing permissions and limitations
# under the Licence.


FROM python:3.8-slim-buster

LABEL maintainer="Paolo Smiraglia <paolo.smiraglia@gmail.com>"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        xmlsec1 \
        libxml2-dev \
        libxmlsec1-dev \
        libxmlsec1-openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && adduser \
        --disabled-password \
        --home /spid \
        --quiet \
        spid

COPY . /tmp/src/
RUN pip install --no-cache-dir /tmp/src/ \
    && rm -fr /tmp/src

WORKDIR /spid
USER spid

ENTRYPOINT ["spid_sp_test"]
CMD ["--help"]
