# container-anycast-dns

```
docker built -t container-anycast-dns .
docker run -d --name=container-anycast-dns --cap-add=NET_ADMIN -p 5333:53/udp -p 5333:53 container-anycast-dns
```
