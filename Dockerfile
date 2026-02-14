FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/corazawaf/coraza-caddy/v2 \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# (Optional) Add your Caddyfile or Coraza config here
# COPY Caddyfile /etc/caddy/Caddyfile
