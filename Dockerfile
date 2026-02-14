# --- Builder ---
FROM caddy:builder AS builder
RUN xcaddy build --with github.com/corazawaf/coraza-caddy/v2

# --- Final ---
FROM caddy:alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# 创建目录并同步规则（对应 Action 中的 Prepare 步骤）
RUN mkdir -p /etc/caddy/coraza/rules
COPY coraza.conf /etc/caddy/coraza/coraza.conf
COPY crs-setup.conf /etc/caddy/coraza/crs-setup.conf
COPY rules/ /etc/caddy/coraza/rules/
