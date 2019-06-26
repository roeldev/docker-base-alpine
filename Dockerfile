# use linuxserver.io alpine base image
# https://hub.docker.com/r/lsiobase/alpine/
# https://github.com/linuxserver/docker-baseimage-alpine/blob/master/Dockerfile
FROM lsiobase/alpine:3.9 as base
RUN set -x \
 && rm -rf \
    /config \
    /defaults \
    /tmp/*

# create actual image
FROM scratch
COPY --from=base / /
COPY systemfiles/ /

# environment variables
ENV ENV="/etc/motd" \
    PS1="$(whoami)@$(hostname):$(pwd) \\$ " \
    HOME="/root" \
    TERM="xterm-256color"

RUN set -x \
 && chmod +x /docker-mods

ENTRYPOINT ["/init"]
