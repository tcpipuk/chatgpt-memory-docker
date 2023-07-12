# Use an official Python runtime as a parent image
FROM python:3.11-alpine AS builder

# Set work directory in the builder
WORKDIR /build

# Install build dependencies and build Arrow
RUN apk add --no-cache --virtual .build-deps \
    boost-dev \
    brotli-dev \
    cargo \
    cmake \
    curl-dev \
    g++ \
    gcc \
    gflags-dev \
    git \
    glog-dev \
    gtest \
    lz4-dev \
    llvm-dev \
    make \
    musl-dev \
    openssl-dev \
    pkgconfig \
    protobuf \
    py3-aiosignal \
    py3-apache-arrow \
    py3-dateutil \
    py3-frozenlist \
    py3-multidict \
    py3-numpy \
    py3-pandas \
    py3-pyarrow \
    py3-tqdm \
    py3-tzdata \
    py3-yarl \
    py3-zipp \
    rapidjson-dev \
    re2-dev \
    rust \
    snappy-dev \
    utf8proc \
    zlib-dev \
    zstd-dev

# Install poetry, clone the chatgpt-memory repository, and install the package
RUN pip install --no-cache-dir poetry \
 && git clone https://github.com/continuum-llms/chatgpt-memory.git \
 && poetry config virtualenvs.create false \
 && cd chatgpt-memory \
 && export ARROW_HOME=/usr/local \
 && export CMAKE_INCLUDE_PATH=/usr/local/include \
 && export CMAKE_LIBRARY_PATH=/usr/local/lib \
 && poetry install --no-interaction --no-ansi

# Start a new stage for the final image
FROM python:3.11-alpine

# Set work directory in the container
WORKDIR /app

# Install runtime dependencies
RUN apk add --no-cache libstdc++

# Copy the installed package from the builder
COPY --from=builder /usr/local /usr/local

# Copy the current directory contents into the container at /app
COPY . /app

# Ensure compiled dependencies are in library path
ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

# Run app.py when the container launches
CMD ["python", "app.py"]
