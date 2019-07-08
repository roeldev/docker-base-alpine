build:
	docker build -t roeldev/base-alpine:local .

start:
	docker run --name base-alpine roeldev/base-alpine:local

stop:
	docker stop base-alpine
	docker rm base-alpine

restart: stop start

login:
	docker exec -it base-alpine bash
