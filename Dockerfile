FROM alpine:3.19.1 as build

# Obtain CoreDNS binary
WORKDIR /tmp
ADD https://github.com/coredns/coredns/releases/download/v1.11.1/coredns_1.11.1_linux_amd64.tgz ./coredns.tgz
RUN tar xzvf coredns.tgz

FROM alpine:3.19.1

# CoreDNS
COPY --chown=root:root --from=build /tmp/coredns /usr/bin/
RUN mkdir -p /etc/coredns

# ExaBGP
RUN apk --no-cache add python3 py3-pip bind-tools \
    && python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install exabgp \ 
    && mkdir -p /etc/exabgp

ENV PATH /opt/venv/bin:$PATH

COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
