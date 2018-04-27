FROM ubuntu:16.04
LABEL author="Corentin Debost <corentin.debost@kaazing.com>"

# Install base dependencies
RUN apt-get update -y && apt-get update && apt-get upgrade -y
RUN apt-get install -y -q \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        zip \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        wget \
        devscripts \
        autoconf \
        ssl-cert \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/*  \
    && rm -rf /var/lib/apt/lists/*

# Install glTFConverter converter
RUN apt-get update -y && apt-get update && \
    apt-get install -y libxml2-dev libpng12-dev libpcre3-dev cmake \
    && apt-get clean
RUN git clone https://github.com/KhronosGroup/glTF.git /tmp/glTF
RUN cd /tmp/glTF/ && git checkout 63e932907e3f0c834c8668d04f03ddb6eabf78d1 && git submodule init && git submodule update
RUN cd /tmp/glTF/converter/COLLADA2GLTF && cmake . && make
RUN mv /tmp/glTF/converter/COLLADA2GLTF/bin/collada2gltf /usr/bin/collada2gltf
RUN chmod +x /usr/bin/collada2gltf && rm -rf /tmp/glTF

