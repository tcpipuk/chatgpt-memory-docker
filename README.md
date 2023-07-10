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

3. Build and run the Docker containers:

```bash
docker-compose up --build
```

This will start two Docker containers: one for the ChatGPT Memory application and one for the Redis service. Docker Compose will automatically link these two containers, and the application will be able to connect to the Redis service using the hostname `redis`.

## Interacting with the Application

Once the Docker containers are up and running, you can interact with the ChatGPT client in the terminal. The client will remember the context of the conversation using the Redis datastore.

## License

This project is licensed under the terms of the MIT license.