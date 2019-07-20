docker-base-alpine
==================

[![Latest release][latest-release-img]][latest-release-url]
[![Travis build status][travis-build-img]][travis-build-url]
[![Docker build status][docker-build-img]][docker-build-url]
[![Docker Hub downloads][docker-pulls-img]][docker-pulls-url]

[latest-release-img]: https://img.shields.io/github/release/roeldev/docker-base-alpine.svg?label=latest
[latest-release-url]: https://github.com/roeldev/docker-base-alpine/releases
[travis-build-img]: https://img.shields.io/travis/roeldev/docker-base-alpine.svg
[travis-build-url]: https://travis-ci.org/roeldev/docker-base-alpine
[docker-build-img]: https://img.shields.io/docker/cloud/build/roeldev/base-alpine.svg
[docker-build-url]: https://hub.docker.com/r/roeldev/base-alpine
[docker-pulls-img]: https://img.shields.io/docker/pulls/roeldev/base-alpine.svg
[docker-pulls-url]: https://hub.docker.com/r/roeldev/base-alpine


A custom base image build with Alpine Linux and S6 overlay. Inspired by LinuxServer.io's `docker-baseimage-alpine`.


## Versions

| Image | Info |
|-------|------|
| [roeldev/base-alpine:3.9-latest][docker-tags-url] | [![mb-3.9-img]][mb-3.9-url]
| [roeldev/base-alpine:3.10-latest][docker-tags-url] | [![mb-3.10-img]][mb-3.10-url]

[docker-tags-url]: https://hub.docker.com/r/roeldev/base-alpine/tags
[mb-3.9-img]: https://images.microbadger.com/badges/image/roeldev/base-alpine:3.9-latest.svg
[mb-3.9-url]: https://microbadger.com/images/roeldev/base-alpine:3.9-latest
[mb-3.10-img]: https://images.microbadger.com/badges/image/roeldev/base-alpine:3.10-latest.svg
[mb-3.10-url]: https://microbadger.com/images/roeldev/base-alpine:3.10-latest


## Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| PUID | | Highly recommended, see below for explanation.
| PGID | | Highly recommended, see below for explanation.
| DISPLAY_MOTD | true | Set to `true` to display system info at container startup.
| VERBOSE_INIT | false | Set to `true` to verbose execute init commands. Helpful to see what's happening during container startup.


## User and group identifiers
When using volumes (`-v` flags) permissions issues can arise between the host OS and the container. This issue is avoided by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will be resolved.

To find yours use `id user` as below. This will result in `PUID=1000` and `PGID=100`.

```
  $ id user
    uid=1000(user) gid=100(group) groups=100(group)
```


## Links
- GitHub: https://github.com/roeldev/docker-base-alpine
- Docker Hub: https://hub.docker.com/r/roeldev/base-alpine
- Alpine Linux: https://alpinelinux.org/
- S6 overlay: https://github.com/just-containers/s6-overlay

## Inspired by
- https://github.com/linuxserver/

## License
[GPL-3.0+](LICENSE) © 2019 [Roel Schut](https://roelschut.nl)
