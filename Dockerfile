FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/corazawaf/coraza-caddy/v2

FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN mkdir -p /etc/caddy/coraza/rules

COPY ./coraza.conf /etc/caddy/coraza/coraza.conf
COPY ./crs-setup.conf /etc/caddy/coraza/crs-setup.conf
COPY ./rules/ /etc/caddy/coraza/rules/

EXPOSE 80 443 443/udp
