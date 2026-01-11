FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/opencoffee/caddy-filter

FROM caddy:alpine

# 替换系统自带的 caddy 二进制文件
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
