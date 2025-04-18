# PocketBase Docker

- *This is not an official repository*
- GitHub: [github.com/BakirGracic/pocketbase-docker](https://github.com/BakirGracic/pocketbase-docker)
- Docker Hub: [bakirg/pocketbase](https://hub.docker.com/repository/docker/bakirg/pocketbase)
- Images have `latest` and PocketBase version tags (e.g. `0.26.6`)

---

![PocketBase](https://i.imgur.com/5qimnm5.png)

## What is PocketBase

PocketBase is an open-source backend (or BaaS) built as a single Go binary that provides:
- **Embedded SQLite Database** with real-time subscriptions
- **Authentication** and **User Management**
- **File Storage** and **Static File Serving**
- **Admin Dashboard** for easy management
- **REST-ish API** server for integrations
- Extendable using **Go** or **JavaScript**
- and much [more](https://pocketbase.io/)

## Features of PocketBase Docker

- **Lean & Secure:** Optimized using lightweight Alpine images and operation layering
- **Data Persistence:** Configurable volumes for `pb_data`, `pb_public`, `pb_migrations` and `pb_hooks` persistance
- **Health Checks:** Built‑in support for Docker health checks
- **Unofficial:** Not opinionated, welcoming contributions
- **Configurable:** Ability to configure some parameters

## Getting Started

### Prerequisites

- Docker Engine (v20.10+)
- Docker Compose (if using compose)

### Defaults

- Before starting PocketBase `serve`, default superuser is created (if pb_data directory doesn't exist) with `test@test.com` & `Test123!` credentials (make sure to change later)

### Building the Image

```bash
git clone https://github.com/BakirGracic/pocketbase-docker
cd pocketbase-docker
docker build -t pocketbase:test_build .
```

### Running the Container

#### Using Docker CLI

```bash
docker run -d \
  --name pocketbase \
  -p 8090:8090 \
  -v $(pwd)/pb_data:/pb_data \
  -v $(pwd)/pb_migrations:/pb_migrations \
  -v $(pwd)/pb_hooks:/pb_hooks \
  -v $(pwd)/pb_public:/pb_public \
  docker.io/bakirg/pocketbase:latest
```

#### Using Docker Compose

```yaml
services:
  pocketbase:
    image: docker.io/bakirg/pocketbase:latest
    container_name: pocketbase
    restart: unless-stopped
    ports:
      - "8090:8090"
    volumes:
      - "${PWD}/pb_data:/pb_data"
      - "${PWD}/pb_migrations:/pb_migrations" 
      - "${PWD}/pb_hooks:/pb_hooks" 
      - "${PWD}/pb_public:/pb_public" 
```

### Accessing PocketBase

- **Admin UI:** [http://localhost:8090/_/](http://localhost:8090/_/)
- **API Endpoint:** [http://localhost:8090/api/](http://localhost:8090/api/)
- **Health Check** [http://localhost:8090/api/health](http://localhost:8090/api/health)

## Contributing

I welcome contributions to improve the Docker images and configurations. Please open issues or pull requests on GitHub.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any (adequate) inquiries, please contact [me@bakir.dev](mailto:me@bakir.dev).
