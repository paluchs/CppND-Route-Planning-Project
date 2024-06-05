FROM ubuntu:20.04
LABEL description="CppND-Route-Planning-Project-BuildEnv"

ENV HOME /root

# This is necessary so that tzdata doesn't get stuck during installation
# See: https://dev.to/grigorkh/fix-tzdata-hangs-during-docker-image-build-4o9m
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install all deps
RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    build-essential \
    cmake \
    wget \
    git \
    libcairo2-dev \
    libgraphicsmagick1-dev \
    libpng-dev \
    catch

# Install io2d
RUN git clone https://github.com/cpp-io2d/P0267_RefImpl
RUN cd P0267_RefImpl && \
    mkdir Debug && \
    cd Debug && \
    cmake --config Debug "-DCMAKE_BUILD_TYPE=Debug" .. && \
    cmake --build . && \ 
    make && \
    make install