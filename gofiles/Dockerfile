FROM golang:alpine AS builder

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Move to working directory /build
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy the code into the container
COPY . .

# Build the application
WORKDIR /build/cmd/httpserver
RUN go build -o main .

RUN wget -O wait-for https://raw.githubusercontent.com/eficode/wait-for/v2.1.3/wait-for
RUN chmod +x wait-for

# CMD ./main

# Move to /dist directory as the place for resulting binary folder
#  WORKDIR /dist

# Copy binary from build to main folder
#  RUN cp /build/cmd/httpserver/main .

# Build a small image
#  FROM scratch

#  COPY --from=builder /dist/main /

# Command to run
#  ENTRYPOINT ["/main"]
