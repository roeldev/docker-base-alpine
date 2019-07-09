CONTAINER=base-alpine

.PHONY it:
it: build start

.PHONY build:
build:
	docker-compose build local

.PHONY start:
start:
	docker-compose up local

.PHONY stop:
stop:
	docker stop ${CONTAINER}
	docker rm ${CONTAINER}

.PHONY restart:
restart: stop start

.PHONY login:
login:
	docker exec -it ${CONTAINER} bash
