# Use an official Python runtime as a parent image
FROM python:3.11-alpine AS builder

# Set work directory in the builder
WORKDIR /build

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps gcc g++ musl-dev rust cargo pkgconfig openssl-dev git

# Install Poetry
RUN pip install --no-cache-dir poetry

# Set environment variable to disable creation of virtualenvs
ENV POETRY_VIRTUALENVS_CREATE=false

# Clone the chatgpt-memory repository
RUN git clone https://github.com/continuum-llms/chatgpt-memory.git

# Install the package
WORKDIR /build/chatgpt-memory
RUN poetry install

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

# Run app.py when the container launches
CMD ["python", "app.py"]
