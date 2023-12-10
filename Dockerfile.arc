FROM golang:1.21.3 as maker

# Set the Current Working Directory inside the container
WORKDIR /app
ENV BRANCH=main
RUN git clone --branch $BRANCH https://github.com/bitcoin-sv/arc.git

# Download all dependencies. Dependencies will be cached if the go.mod and the go.sum files are not changed
WORKDIR /app/arc
RUN go mod vendor
RUN make build_release

RUN chmod +x /app/arc/build/arc_linux_amd64

CMD ["/app/arc/build/arc_linux_amd64"]
