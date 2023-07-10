# Use an official Python runtime as a parent image
FROM python:3.11-alpine AS builder

# Set work directory in the builder
WORKDIR /build

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps gcc musl-dev rust cargo

# Install the package
RUN pip install --no-cache-dir --prefix=/install chatgpt-memory

# Start a new stage for the final image
FROM python:3.11-alpine

# Set work directory in the container
WORKDIR /app

# Copy the installed package from the builder
COPY --from=builder /install /usr/local

# Copy the current directory contents into the container at /app
COPY . /app

# Run app.py when the container launches
CMD ["python", "app.py"]
