# ChatGPT Memory Docker Project

This project provides a Dockerized setup for running the ChatGPT Memory project, which allows you to scale the ChatGPT API to multiple simultaneous sessions with infinite contextual and adaptive memory powered by GPT and Redis datastore.

## Prerequisites

- Docker
- Docker Compose

## Setup

1. Clone this repository:

```bash
git clone https://github.com/tcpipuk/chatgpt-memory-docker.git
cd chatgpt-memory-docker
```

2. Create a `.env` file in the root directory of the project and add your OpenAI API key and Redis password:

```env
OPENAI_API_KEY=your-openai-api-key
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD=your-redis-password
```

Replace `your-openai-api-key` and `your-redis-password` with your actual OpenAI API key and Redis password.

## Running the Application

You have two options to run the application:

### Using Docker Compose

To run the Docker containers using Docker Compose while interacting with the Python input lines, you can run the `app` service in the foreground:

```bash
docker-compose run app
```

### Using Docker Run

Alternatively, you can use Docker run to start the application in interactive mode:

```bash
docker network create chatgpt_network
docker run --name redis --network chatgpt_network -d redis:alpine
docker run -it --rm --name chatgpt_memory --network chatgpt_network --env-file .env tcpipuk/chatgpt-memory:latest
```

Then to stop and remove everything created:

```bash
docker stop chatgpt_memory redis
docker network rm chatgpt_network
```

## Docker Image

The Docker image for this project is automatically built and hosted on Docker Hub. You can find it at [tcpipuk/chatgpt-memory](https://hub.docker.com/r/tcpipuk/chatgpt-memory).

## License

This project is licensed under the terms of the MIT license.
