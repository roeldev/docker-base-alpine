CONTAINER=base-alpine

.PHONY it:
it: build tag start

.PHONY build:
build:
	docker-compose build --force-rm local

.PHONY start:
start:
	docker-compose up local

.PHONY stop:
stop:
	docker stop ${CONTAINER}
	docker rm ${CONTAINER}

.PHONY restart:
restart: stop start

.PHONY tag:
tag:
	docker tag roeldev/base-alpine:local roeldev/base-alpine:3.9-v1

.PHONY login:
login:
	docker exec -it ${CONTAINER} bash
