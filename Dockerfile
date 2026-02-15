FROM golang:alpine AS builder

RUN apk add --no-cache git gcc musl-dev

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 xcaddy build \
    --with github.com/corazawaf/coraza-caddy/v2 \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:alpine

COPY --from=builder /go/caddy /usr/bin/caddy

RUN mkdir -p /etc/caddy/waf

EXPOSE 80 443 443/udp
