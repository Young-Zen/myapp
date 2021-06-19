FROM golang:1.14-alpine AS builder
WORKDIR /root
COPY main.go   .
RUN CGO_ENABLED=0 GOOS=linux go build -o myapp .

FROM alpine:3.12
WORKDIR /root
COPY --from=builder /root/myapp .
CMD ["./myapp"]
