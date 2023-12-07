FROM golang:1.21.3 as maker

# Set the Current Working Directory inside the container
WORKDIR /app
# COPY . ./

ENV BRANCH=main
RUN git clone --branch $BRANCH https://github.com/bitcoin-sv/arc.git
WORKDIR /app/arc

# Download all dependencies. Dependencies will be cached if the go.mod and the go.sum files are not changed
RUN go mod vendor
RUN make build_release


FROM ubuntu:latest


RUN apt update && apt install -y lsof && apt clean

# RUN apt-get update && apt-get install ca-certificates -y  && apt clean && rm -rf /var/lib/apt/lists/*
WORKDIR /service
COPY --from=0 /app/arc/build/arc_linux_amd64 /service/arc
COPY --from=0 /app/arc/test/config/config.yaml /service/
RUN ls -la /
RUN chmod +x arc
# EXPOSE 9090

CMD ["/service/arc"]
