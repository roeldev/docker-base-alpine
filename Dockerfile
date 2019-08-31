ARG ALPINE_VERSION="3.9"
FROM alpine:${ALPINE_VERSION} as base

RUN set -x \
 && apk update \
 # add dependencies
 && apk add \
    --no-cache \
        bash \
        tar \
        tzdata \
        xz \
 && mkdir /root-out

# vars used in mkimage-alpine.bash script
ARG ALPINE_VERSION
ENV REL="v${ALPINE_VERSION}" \
    ARCH="x86_64" \
    MIRROR="http://dl-cdn.alpinelinux.org/alpine" \
    PACKAGES="alpine-baselayout,\
alpine-keys,\
apk-tools,\
busybox,\
libc-utils,\
xz"

# run builder script from gliderlabs
ADD https://raw.githubusercontent.com/gliderlabs/docker-alpine/master/builder/scripts/mkimage-alpine.bash /mkimage-alpine.bash
RUN set -x \
 && chmod +x /mkimage-alpine.bash \
 && ./mkimage-alpine.bash \
 && tar xf /rootfs.tar.xz -C /root-out \
 && sed -i -e 's/^root::/root:!:/' /root-out/etc/shadow

# set version for s6 overlay
ARG OVERLAY_VERSION="v1.22.1.0"
ARG OVERLAY_ARCH="amd64"

# download s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz /s6-overlay.tar.gz
RUN set -x \
 && tar xzf /s6-overlay.tar.gz -C /root-out

# create script to return current alpine version
WORKDIR /root-out/usr/local/bin
RUN set -x \
 && echo "#!/bin/sh" >> alpine_version \
 && echo "echo \"${ALPINE_VERSION}\"" >> alpine_version

###############################################################################
# create actual image
###############################################################################
FROM scratch
COPY --from=base /root-out /

# environment variables, these may be changed using docker cli
ENV ENV="/etc/motd" \
    PS1="$(whoami)@$(hostname):$(pwd) \\$ " \
    DISPLAY_MOTD="true" \
    VERBOSE_INIT="false" \
    PUID="911" \
    PGID="911"

RUN set -x \
 && apk update \
 # upgrade installed programs to latest version
 && apk upgrade --no-cache \
 # add basic programs
 && apk add \
    --no-cache \
        bash \
        ca-certificates \
        coreutils \
        shadow \
        tzdata \
 # set group and user
 && addgroup -g 911 -S abc \
 && adduser \
    -D -H -S \
    -u 911 \
    -h /app \
    -s /sbin/nologin \
    -G abc \
    abc \
 && usermod --groups users abc \
 # make alpine_version executable so it can be used
 # in commands in other Dockerfiles
 && chmod +x /usr/local/bin/alpine_version

# add local files
COPY rootfs/ /

VOLUME ["/config"]
ENTRYPOINT ["/init"]
