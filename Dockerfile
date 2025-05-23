ARG PB_VERSION=0.28.0

FROM alpine:latest AS setup

ARG PB_VERSION
WORKDIR /setup

RUN apk add --no-cache unzip ca-certificates
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d ./

FROM alpine:latest AS app

ARG PB_VERSION

WORKDIR /app
COPY --from=setup /setup/pocketbase ./pocketbase
COPY entrypoint.sh ./entrypoint.sh

RUN addgroup -S pocketbase && adduser -SG pocketbase pocketbase
RUN chmod +x ./entrypoint.sh ./pocketbase
RUN chown -R pocketbase:pocketbase ./
USER pocketbase

EXPOSE 8090

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]

LABEL org.opencontainers.image.title="Pocketbase Docker"
LABEL org.opencontainers.image.description="Unofficial repository of PocketBase project images"
LABEL org.opencontainers.image.version="${PB_VERSION}"
LABEL org.opencontainers.image.authors="Bakir Gracic <me@bakirg.dev>"
LABEL org.opencontainers.image.source="https://github.com/bakirgracic/pocketbase-docker"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.documentation="https://github.com/BakirGracic/pocketbase-docker/blob/main/README.md"
