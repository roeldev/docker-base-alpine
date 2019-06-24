# use linuxserver.io alpine base image
# https://hub.docker.com/r/lsiobase/alpine/
# https://github.com/linuxserver/docker-baseimage-alpine/blob/master/Dockerfile
FROM lsiobase/alpine:3.9 as base
RUN set -x \
 && rm -rf \
    /config \
    /defaults

# runtime stage
FROM scratch
COPY --from=base / /

# labels
ARG DOCKER_REPO
ARG DOCKER_TAG
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF
ARG LABEL_VCS_URL
LABEL maintainer="roeldev" \
      org.label-schema.name="${DOCKER_REPO}" \
      org.label-schema.version="${DOCKER_TAG}" \
      org.label-schema.build-date="${LABEL_BUILD_DATE}" \
      org.label-schema.vcs-ref="${LABEL_VCS_REF}" \
      org.label-schema.vcs-url="${LABEL_VCS_REF}" \
      org.label-schema.schema-version="1.0"

# environment variables
ENV ENV="/etc/motd" \
    PS1="$(whoami)@$(hostname):$(pwd) \\$ " \
    HOME="/root"

COPY systemfiles/ /
ENTRYPOINT ["/init"]
