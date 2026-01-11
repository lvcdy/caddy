FROM caddy:builder AS builder
RUN xcaddy build --with github.com/caddyserver/replace-response
FROM caddy:alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
