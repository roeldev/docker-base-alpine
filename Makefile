# local.image (without tag)
IMAGE_NAME=roeldev/base-alpine
# local.container_name
CONTAINER_NAME=base-alpine

.PHONY it:
it: build tag start

.PHONY build:
build:
	docker-compose build local

.PHONY start:
start:
	docker-compose up local

.PHONY stop:
stop:
	docker stop ${CONTAINER_NAME}

.PHONY kill:
kill: stop
	docker rm ${CONTAINER_NAME}

.PHONY restart:
restart: stop start

.PHONY inspect:
inspect:
	docker inspect ${IMAGE_NAME}:local

.PHONY tag:
tag:
	docker tag ${IMAGE_NAME}:local ${IMAGE_NAME}:3.9-v1

.PHONY login:
login:
	docker exec -it ${CONTAINER_NAME} bash
