FROM golang:1.21.3 as maker

# Set the Current Working Directory inside the container
WORKDIR /app/arc
COPY . ./

# Download all dependencies. Dependencies will be cached if the go.mod and the go.sum files are not changed
RUN go mod vendor
RUN make build_release

RUN chmod +x /app/arc/build/arc_linux_amd64

CMD ["/app/arc/build/arc_linux_amd64"]
