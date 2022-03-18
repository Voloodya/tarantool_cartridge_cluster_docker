SHELL := /bin/bash
TARANTOOL_BUNDLE_VERSION := 2.8.2-0-gfc96d10f5-r437
CI_DELAY?=5

.PHONY: build-image-cartridge
build-image-cartridge:
	docker build -t tarantool_cartridge .
	sleep $(CI_DELAY)

#.PHONY: docker-delete-container-cartridge
#delete-container-cartridge:
#	docker stop
#	docker rm

.PHONY: docker-delete-image-cartridge
docker-delete-image-cartridge:
	docker rmi tarantool_cartridge
	sleep $(CI_DELAY)

.PHONY: docker-cluster-down
docker-cluster-down:
	docker-compose -f docker-compose.yml down -v

.PHONY: docker-cluster-up
docker-cluster-up: build-image-cartridge
	docker-compose -f docker-compose.yml up -d -V
	sleep $(CI_DELAY)

.PHONY: docker-cluster-restart
docker-cluster-restart: docker-cluster-down docker-cluster-up

.PHONY: docker-claster-new_create
docker-claster-new_create: docker-cluster-down docker-delete-image-cartridge build-image-cartridge docker-cluster-up
