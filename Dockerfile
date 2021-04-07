FROM golang:1.14-alpine AS builder
WORKDIR /root
COPY main.go   .
RUN CGO_ENABLED=0 GOOS=linux go build -gcflags "all=-N -l" -o myapp .

FROM golang:1.14-alpine
RUN apk add --no-cache tzdata git \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && go get -u github.com/derekparker/delve/cmd/dlv
WORKDIR /root
COPY --from=builder /root/myapp .
CMD ${ENABLE_DEBUG:+dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient exec --continue} ./myapp
