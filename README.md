# container-anycast-dns

Containerized ExaBGP + CoreDNS to act as an Anycast DNS server

# Configuration

The image expects to be provided valid configuration files at the following locations

* `/etc/coredns/Corefile`
* `/etc/exabgp/exabgp.conf`

NOTE: You will need to launch the container with `NET_ADMIN` capability if you wish for it to add/remove IPs
