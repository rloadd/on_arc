FROM golang:1.21.3 as maker

# Set the Current Working Directory inside the container
WORKDIR /app
ENV BRANCH=main
RUN git clone --branch $BRANCH https://github.com/bitcoin-sv/arc.git
WORKDIR /app/arc

# Download all dependencies. Dependencies will be cached if the go.mod and the go.sum files are not changed
# RUN go mod vendor
RUN make build_release

WORKDIR /service
RUN cp /app/arc/build/arc_linux_amd64 /service/arc
RUN chmod a+x /service/arc
CMD ["/service/arc"]
