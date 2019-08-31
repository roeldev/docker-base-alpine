# local.image (without tag)
IMAGE_NAME=roeldev/base-alpine
# local.container_name
CONTAINER_NAME=base-alpine

it: build tag start

build:
	docker-compose build local

start:
	docker-compose up local

stop:
	docker stop ${CONTAINER_NAME}

kill: stop
	docker rm ${CONTAINER_NAME}

restart: stop start

inspect:
	docker inspect ${IMAGE_NAME}:local

tag:
	docker tag ${IMAGE_NAME}:local ${IMAGE_NAME}:3.9-v1

login:
	docker exec -it ${CONTAINER_NAME} bash

.PHONY it build start stop kill restart inspect tag login:
