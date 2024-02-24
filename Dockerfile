FROM debian:bookworm-slim as build

# Obtain CoreDNS binary
WORKDIR /tmp
ADD https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_amd64.tgz ./coredns.tgz
RUN tar xzvf coredns.tgz

FROM debian:bookworm-slim

# CoreDNS
COPY --chown=root:root --from=build /tmp/coredns /usr/bin/
RUN mkdir -p /etc/coredns
COPY Corefile /etc/coredns

# ExaBGP
RUN apt-get update && apt-get install -y \
    iproute2 \
    dnsutils \
    exabgp
COPY exabgp.conf /etc/exabgp
COPY health_check_dns /etc/exabgp
RUN mkfifo /run/exabgp/exabgp.in /run/exabgp/exabgp.out && \
    chmod 600 /run/exabgp/exabgp.in /run/exabgp/exabgp.out && \
    chown exabgp:exabgp /run/exabgp/exabgp.in /run/exabgp/exabgp.out

COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
